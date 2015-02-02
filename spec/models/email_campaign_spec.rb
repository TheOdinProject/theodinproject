require 'spec_helper'

describe EmailCampaign do

  it "must have a mailer_name" do
    expect(EmailCampaign.new).to have(1).error_on(:mailer_name)
  end

  it "must have a method name" do
    expect(EmailCampaign.new).to have(1).error_on(:method_name)
  end

  it "must have a unique method name" do
    FactoryGirl.create(:email_campaign, method_name: "mailer_method")
    duplicate = EmailCampaign.new(method_name: "mailer_method")
    expect(duplicate).to have(1).error_on(:method_name)
  end  

  it "must have an email_campaign_category" do
    expect(EmailCampaign.new).to have(1).error_on(:email_campaign_category)
  end
end
