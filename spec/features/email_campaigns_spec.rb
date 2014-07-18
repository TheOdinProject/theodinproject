require 'spec_helper'

describe "Email Campaigns" do 

  it "stores mailer and method name in campaign" do
    ec = EmailCampaign.new
    ec.name = "Test"
    ec.method_name = "Mailer.method"
    ec.save
    EmailCampaign.find_by_method_name("Mailer.method").should_not be_nil
  end

  #TODO
  #it "organizes campaigns into categories" do
  #end

  it "records sent emails (sent to one person)" do 
    FactoryGirl.create(:user, :email => "foo@bar.com")
    expect {TestMailer.email_one_person.deliver}.to change(SentEmail.count).by(1)
  end
  
  
end