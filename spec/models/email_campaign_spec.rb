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

  it "must have a valid email_campaign_category" do
    c = EmailCampaign.new
    c.email_campaign_category_id = 1
    expect(c).to have(1).error_on(:email_campaign_category)
  end

  specify "happy path" do
    c = EmailCampaign.new
    c.mailer_name = "Mailer"
    c.method_name = "unique_method_name"
    c.email_campaign_category = FactoryGirl.create(:email_campaign_category)
    expect(c.valid?).to eq(true)
  end
end
