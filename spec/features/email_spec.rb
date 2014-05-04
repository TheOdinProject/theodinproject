require 'spec_helper'

describe "Users registered before email confirmations were added need to verify their account" do 

  let!(:user) { FactoryGirl.create(:user, :reg_before_conf => true, :confirmed_at => nil) }
  before { sign_in(user) }

  it "should prompt the user to confirm email when they sign in" do
    page.should have_selector("div", text: "Please confirm your email address.")
  end

  it "should not block the user from accessing the site" do
    page.should have_selector('h1', text: "This is Your Path to Learning Web Development")
  end

  it "should provide a link to request confirmation instructions" do
    page.should have_link("Didn't receive confirmation instructions, or need them again?")
  end

  it "should send an email with confirmation instructions" do
    click_on("Didn't receive confirmation instructions, or need them again?")
    ActionMailer::Base.deliveries.last.encoded.should include "Confirm my account"
  end

  it "should not send the welcome email (since the user received it when they first signed up)" do
    # Create new user to verify that no email is created when they confirm their account
    # Necessary because tests are not run in order, so user status may not be what we expect 
    other_user = FactoryGirl.create(:user, :reg_before_conf => true, :confirmed_at => nil)
    expect(other_user.confirm!).to_not change(ActionMailer::Base.deliveries.count).by(1)
  end
    
  it "should stop prompting user to confirm after they have done so" do
    confirmed_user = FactoryGirl.create(:user, :reg_before_conf => true, :confirmed_at => Time.now)
    sign_in(confirmed_user)
    page.should have_no_selector("div", text: "Please confirm your email address")
  end
  
end