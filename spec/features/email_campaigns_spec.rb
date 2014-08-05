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
        FactoryGirl.create(:email_campaign_category)
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
        puts @email
        link = @email.match(/href="(.*unsubscribe.*)"/)[1]
        visit link
        expect(page).to have_selector('div', text: "Unsubscribe")
      end
    end


  end
  
  
end