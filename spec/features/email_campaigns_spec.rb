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
    context "from link in email" do
      before do
        FactoryGirl.create(:email_campaign_category, name: "Marketing")
        FactoryGirl.create(:email_campaign_category, name: "Newsletter")
        FactoryGirl.create(:email_campaign_category, name: "Transactional")
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
          page.check("categories[unsubscribe_all]")
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
          page.check("categories[unsubscribe_all]")
          click_on "Submit"
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
  end 
end