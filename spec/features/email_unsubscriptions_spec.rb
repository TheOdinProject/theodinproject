require 'spec_helper'  

describe "Manage Email Unsubscriptions" do
  let!(:user1) {FactoryGirl.create(:user)}
  let!(:user2) {FactoryGirl.create(:user)}

  describe "Pages don't blow up if there are no categories" do
    before {EmailCampaignCategory.destroy_all}

    specify "Generic unsubscribe page gives error message" do
      visit email_unsubscribe_path   # No EmailCampaignCategories have been created
      expect(page).to have_selector('div', text: "We're sorry. Something went wrong.")
    end

    specify "Update email preferences page gives error message" do
      visit logout_path  #To be safe - make sure no one is logged in
      sign_in(user1)
      visit email_preferences_path   #No EmailCampaignCategories have been created
      expect(page).to have_selector('div', text: "We're sorry. Something went wrong.")
    end
  end

  before do
    FactoryGirl.create(:email_campaign_category, name: "Marketing")
    FactoryGirl.create(:email_campaign_category, name: "Newsletter")
    FactoryGirl.create(:email_campaign_category, name: "Transactional")
  end

  describe "On generic unsubscribe page" do
    before { visit '/email_unsubscribe' }

    it "gives error message if email doesn't belong to a User" do
      fill_in("Email address", with: "fake@user.email")
      page.check("categories[All]")
      click_on "Submit"
      expect(page).to have_selector('div', text: "Email address is invalid")
    end

    # SHOW ALL CATEGORIES EXCEPT TRANSACTIONAL

    it "has Marketing option" do
      expect(page).to have_selector('label', text: "Marketing")
    end

    it "has Newsletter option" do
      expect(page).to have_selector('label', text: 'Newsletter')
    end

    it "has Unsubscribe All option" do
      expect(page).to have_selector('label', text: 'All')
    end

    it "does NOT have Transactional option" do
      expect(page).to have_no_selector('label', text: 'Transactional')
    end 

    
    # UNSUBSCRIBE FROM CATEGORIES

    describe "User doesn't unsubscribe from anything" do
      before do
        fill_in("Email address", with: User.last.email)
        click_on "Submit"
      end

      it "shows helpful notification" do
        expect(page).to have_selector('div', 
          text: "Login to view and update preferences from your profile page at any time.")
      end

      it "sends user to courses page" do
        expect(current_path).to eq courses_path
      end
    end
    
    describe "User unsubscribes from one category" do
      before do
        fill_in("Email address", with: User.last.email)
        page.check("categories[Marketing]")
        click_on "Submit"
      end

      it "creates unsubscription" do
        expect(Unsubscription.where(
          user_id: User.last.id, 
          email_campaign_category_id: EmailCampaignCategory.find_by_name("Marketing").id)
          )
       end

      it "shows confirmation" do
        expect(page).to have_selector('div', 
          text: "Subscription preferences have been updated for #{User.last.email}.")
      end
    end

    describe "User unsubscribes from multiple categories" do
      before do
        fill_in("Email address", with: User.last.email)
        page.check("categories[Marketing]")
        page.check("categories[Newsletter]")
        click_on "Submit"
      end

      it "creates first unsubscription" do
        expect(Unsubscription.where(
          user_id: User.last.id, 
          email_campaign_category_id: EmailCampaignCategory.find_by_name("Marketing").id)
          )
      end

      it "creates second unsubscription" do
        expect(Unsubscription.where(
          user_id: User.last.id, 
          email_campaign_category_id: EmailCampaignCategory.find_by_name("Newsletter").id)
          )          
      end

      it "shows confirmation" do
        expect(page).to have_selector('div', 
          text: "Subscription preferences have been updated for #{User.last.email}.")
      end
    end

    describe "User unsubscribes from all categories" do
      before do
        fill_in("Email address", with: User.last.email)
        page.check("categories[All]")
        click_on "Submit"
      end

      it "sets unsubscribe_all flag" do
        expect(User.last.reload.unsubscribe_all?).to be_true
      end
    end

    describe "User with previous unsubscriptions" do
      before do
        Unsubscription.create(
          user_id: User.last.id, 
          email_campaign_category_id: EmailCampaignCategory.find_by_name("Newsletter").id
        )
        fill_in("Email address", with: User.last.email)
        page.check("categories[Marketing]")
        click_on "Submit"
      end
      after { Unsubscription.last.delete }

      it "keeps previous unsubscription intact" do
        expect(Unsubscription.where(
          user_id: User.last.id, 
          email_campaign_category_id: EmailCampaignCategory.find_by_name("Newsletter").id)
          )  
      end        

      it "adds new unsubscription" do
        expect(Unsubscription.where(
          user_id: User.last.id, 
          email_campaign_category_id: EmailCampaignCategory.find_by_name("Marketing").id)
          )          
      end
    end
  end


  describe "Via Link from User Profile Page" do

    specify "User doesn't see link if not logged in" do
      visit user_path(User.first)
      expect(page).to have_no_selector('a', text: "Update email preferences")
    end

    specify "User doesn't see link on other people's profiles" do
      visit logout_path
      sign_in(user1)
      visit user_path(user2)
      expect(page).to have_no_selector('a', text: "Update email preferences")
    end

    specify "Signed in user has link to update email preferences" do
      visit logout_path
      sign_in(user2)
      visit user_path(user2)
      expect(page).to have_selector('a', text: "Update email preferences")
    end

    context "On Update email preferences Page" do
      describe "User with an existing unsubscription" do
        before do
          Unsubscription.create(
            user_id: user1.id,
            email_campaign_category_id: EmailCampaignCategory.find_by_name("Marketing").id
          )
          sign_in(user1)
          visit user_path(user1)
          click_on "Update email preferences"
        end        

        specify "current unsubscriptions are checked" do
          expect(page).to have_checked_field("categories[Marketing]")
        end

        specify "other categories are not checked" do
          expect(page).to have_no_checked_field("categories[Newsletter]")
        end

        it "lets the user add an unsubscription" do
          page.check("categories[Newsletter]")
          click_on "Update"
          expect(Unsubscription.category_names(user1.unsubscriptions)).to include("Newsletter")
          # expect(user1.unsubscriptions).to include(Unsubscription.where(
          #   email_campaign_category_id: EmailCampaignCategory.find_by_name("Newsletter").id))
        end

        it "deletes a previous unsubscription" do
          page.uncheck("categories[Marketing]")
          click_on "Update"
          expect(Unsubscription.category_names(user1.unsubscriptions)).not_to include("Marketing")          
        end

        describe "User unsubscribes from all categories" do
          before do
            page.check("categories[All]")
            click_on "Update"
          end

          it "sets unsubscribe_all flag" do
            expect(user1.reload.unsubscribe_all?).to eq(true)
          end
        end

        describe "User cancels unsubscribe_all" do
          before do 
            user1.update_column(:unsubscribe_all, true)
            visit email_preferences_path
            page.uncheck("categories[All]")
            click_on "Update"
          end

          it "cancels unsubscribe_all flag" do
            expect(user1.reload.unsubscribe_all?).to eq(false)
          end
        end
      end

      describe "User with no previous unsubscriptions" do
        before do
          Unsubscription.destroy_all
          sign_in(user1)
          visit user_path(user1)
          click_on "Update email preferences"
        end

        # NO BOXES SHOULD BE CHECKED
        specify "Marketing category is not checked" do
          expect(page).to have_no_checked_field("categories[Marketing]")
        end

        specify "Newsletter category is not checked" do
          expect(page).to have_no_checked_field("categories[Newsletter]")
        end

        specify "All category is not checked" do
          expect(page).to have_no_checked_field("categories[All]")
        end

        # MANAGE UNSUBSCRIPTIONS
        specify "User doesn't add unsubscriptions" do
          click_on "Update"
          expect(page).to have_selector('div', text: "Thanks for opting in to receive emails")
        end

        describe "User adds multiple unsubscriptions" do
          before do
            page.check("categories[Marketing]")
            page.check("categories[Newsletter]")
            click_on "Update"
          end

          it "adds two unsubscriptions" do
            expect(user1.unsubscriptions.count).to eq(2)
          end

          it "shows 'Marketing' as checked" do
            expect(page).to have_checked_field("categories[Marketing]")
          end

          it "shows 'Newsletter' as checked" do
            expect(page).to have_checked_field("categories[Newsletter]")
          end
        end
      end
    end
  end
end 