require 'spec_helper'

describe "Email Campaigns" do 
  before do
    FactoryGirl.create(:user) # To receive email
  end

  it "stores mailer and method name in campaign" do
    FactoryGirl.create(:email_campaign, method_name: "Mailer.method")
    EmailCampaign.find_by_method_name("Mailer.method").should_not be_nil
  end

  #TODO
  #it "organizes campaigns into categories" do
  #end

  it "records sent emails (sent to one person)" do 
    FactoryGirl.create(:email_campaign_category)
    FactoryGirl.create(:email_campaign, 
      method_name: "TestMailer.email_one_person",
      email_campaign_category: EmailCampaignCategory.last)
    expect {TestMailer.email_one_person}.to change{SentEmail.count}.by(1)
  end

  describe "Users Can Unsubscribe from Campaigns" do
    before do
      FactoryGirl.create(:email_campaign_category, name: "Marketing")
      FactoryGirl.create(:email_campaign_category, name: "Newsletter")
      FactoryGirl.create(:email_campaign_category, name: "Transactional")
      FactoryGirl.create(:email_campaign_category, name: "All")
    end

    context "from link in email" do
      before do
        FactoryGirl.create(:email_campaign, 
          method_name: "TestMailer.email_one_person",
          email_campaign_category: EmailCampaignCategory.last)
        TestMailer.email_one_person
        @email = ActionMailer::Base.deliveries.last.encoded
      end

      it "has link to unsubscribe" do
        expect(@email).to have_link('here')
      end

      it "takes user to generic unsubscribe page" do
        link = @email.match(/href="(.*unsubscribe.*)"/)[1]
        visit link
        expect(page).to have_selector('div', text: "Unsubscribe")
      end

      context "on Unsubscribe page" do
        before do
          link = @email.match(/href="(.*unsubscribe.*)"/)[1]
          visit link
        end
        
        it "lists all categories (except Transactional)" do
          expect(page).to have_selector('label', text: "Marketing")
          expect(page).to have_selector('label', text: 'Newsletter')
        end

        it "does NOT list Transactional category" do
          expect(page).to have_no_selector('label', text: 'Transactional')
        end 

        it "has Unsubscribe All option" do
          expect(page).to have_selector('label', text: 'All')
        end

        it "gives error message if email doesn't belong to a User" do
          fill_in("Email address", with: "fake@user.email")
          click_on "Submit"
          expect(page).to have_selector('div', text: "Email address is invalid")
        end

        specify "user can unsubscribe from one category" do
          fill_in("Email address", with: User.last.email)
          page.check("categories[Marketing]")
          click_on "Submit"
          expect(Unsubscription.where(
            user_id: User.last.id, 
            email_campaign_category_id: EmailCampaignCategory.find_by_name("Marketing").id)
            )
        end

        specify "user can unsubscribe from multiple categories" do
          fill_in("Email address", with: User.last.email)
          page.check("categories[Marketing]")
          page.check("categories[Newsletter]")
          click_on "Submit"
          expect(Unsubscription.where(
            user_id: User.last.id, 
            email_campaign_category_id: EmailCampaignCategory.find_by_name("Marketing").id)
            )
          expect(Unsubscription.where(
            user_id: User.last.id, 
            email_campaign_category_id: EmailCampaignCategory.find_by_name("Newsletter").id)
            )          
        end

        specify "user can unsubscribe from all categories" do
          fill_in("Email address", with: User.last.email)
          page.check("categories[All]")
          click_on "Submit"
          expect(User.last.unsubscribe_all?).to be_true
        end
      end   

      context "after unsubscribing" do
        before do
          link = @email.match(/href="(.*unsubscribe.*)"/)[1]
          visit link
          fill_in("Email address", with: User.last.email)
          page.check("categories[Marketing]")
          page.check("categories[Newsletter]")
          click_on "Submit"
        end

        it "shows confirmation" do
          expect(page).to have_selector('div', text: 
            "Subscription preferences have been updated for #{User.last.email}.")
        end

        it "does not send user email in unsubscribed category" do
          pending
        end
      end

      context "after Unsubscribe All" do
        before do
          link = @email.match(/href="(.*unsubscribe.*)"/)[1]
          visit link
          fill_in("Email address", with: User.last.email)
          page.check("categories[All]")
          click_on "Submit"
        end

        it "sets unsubscribe flag for user" do
          expect(User.last.unsubscribe_all?).to eq(true)
        end

        it "shows confirmation" do
          expect(page).to have_selector('div', text:
            "Email address #{User.last.email} has been unsubscribed from all categories.")
        end

        it "does not send email in existing category" do
          pending        
        end

        it "does not send email in new category" do
          pending
        end

        it "still sends Transactional emails" do
          pending
        end
      end 
    end

    context "Via Link from User Profile Page" do
      let!(:user1) {FactoryGirl.create(:user)}
      let!(:user2) {FactoryGirl.create(:user)}

      specify "User doesn't see link if not logged in" do
        visit user_path(User.first)
        expect(page).to have_no_selector('a', text: "Update Email Preferences")
      end

      specify "User doesn't see link on other people's profiles" do
        visit logout_path
        sign_in(user1)
        visit user_path(user2)
        expect(page).to have_no_selector('a', text: "Update Email Preferences")
      end

      specify "Signed in user has link to update email preferences" do
        visit logout_path
        sign_in(user2)
        visit user_path(user2)
        expect(page).to have_selector('a', text: "Update Email Preferences")
      end

      context "On Update Email Preferences Page" do
        before do
          Unsubscription.unsubscribe(user1, ["Marketing"])
          sign_in(user1)
          visit user_path(user1)
          click_on "Update Email Preferences"
          expect(current_path).to eq email_preferences_path
          expect(user1.unsubscribe_all?).to eq(false)
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
        end

        it "deletes a previous unsubscription" do
          page.uncheck("categories[Marketing]")
          click_on "Update"
          expect(Unsubscription.category_names(user1.unsubscriptions)).not_to include("Marketing")          
        end

        it "lets user unsubscribe from all categories" do
          page.check("categories[All]")
          click_on "Update"
          expect(user1.reload.unsubscribe_all?).to eq(true)
          expect(page).to have_checked_field("categories[All]")
        end

        it "lets user re-subscribe to all categories" do
          user1.update_column(:unsubscribe_all, true)
          visit email_preferences_path
          page.uncheck("categories[Marketing]")          
          page.uncheck("categories[All]")
          click_on "Update"
          expect(user1.unsubscriptions.count).to eq(0)
          expect(user1.reload.unsubscribe_all?).to eq(false)
        end          

        it "lets user remove unsubscribe_all flag" do
          user1.update_column(:unsubscribe_all, true)
          visit email_preferences_path
          page.uncheck("categories[All]")
          click_on "Update"
          expect(user1.reload.unsubscribe_all?).to eq(false)
        end

        context "User with no previous unsubscriptions" do
          before do
            Unsubscription.destroy_all
            visit email_preferences_path
          end

          specify "No boxes are checked" do
            expect(page).to have_no_checked_field("categories[Marketing]")
          end

          specify "User doesn't add unsubscriptions" do
            click_on "Update"
            expect(page).to have_selector('div', text: "Thanks for opting in to receive emails")
          end

          specify "User adds multiple unsubscriptions" do
            page.check("categories[Marketing]")
            page.check("categories[Newsletter]")
            click_on "Update"
            expect(user1.unsubscriptions.count).to eq(2)
            expect(page).to have_checked_field("categories[Marketing]")
            expect(page).to have_checked_field("categories[Newsletter]")
          end
        end

      end
    end
  end 
end