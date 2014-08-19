require 'spec_helper'

describe "Email Campaigns" do 
  before do
    FactoryGirl.create(:user) # To receive email
  end

  it "stores mailer and method name in campaign" do
    FactoryGirl.create(:email_campaign, method_name: "Mailer.method")
    EmailCampaign.find_by_method_name("Mailer.method").should_not be_nil
  end

  it "records sent emails (sent to one person)" do 
    FactoryGirl.create(:email_campaign_category)
    FactoryGirl.create(:email_campaign, 
      method_name: "TestMailer.email_one_person",
      email_campaign_category: EmailCampaignCategory.last)
    expect {TestMailer.email_one_person}.to change{SentEmail.count}.by(1)
  end

  
  # TODO - Email should not be sent to users unsubscribed from that category

  # TODO - Emails in existing categories should not be sent to users
  #        who have unsubscribed from all categories

  # TODO - Emails in new categories should not be sent to users who
  #        who have unsubscribed from all categories
    
end