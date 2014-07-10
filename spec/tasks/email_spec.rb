require 'spec_helper'
require 'rake'

describe "email task" do
  let!(:user) { FactoryGirl.create(:user) }
  before :all do
    Rake.application.rake_require "tasks/email"
    Rake::Task.define_task(:environment)
  end


  describe "send email to one person with api" do
    before do
      Rake.application.invoke_task "email:send[TestMailer,send_test_email,foo@bar.com]" 
      @mail = ActionMailer::Base.deliveries.last
    end

    it "sends an email" do
      @mail.should_not be_nil
    end

    it "has X-SMTPAPI header" do
      @mail.header['X-SMTPAPI'].value.should_not be_nil
    end

    it "formats recipients address correctly" do
      @mail.header['X-SMTPAPI'].value.should eq('{"to":["foo@bar.com"]}')
    end

  end 

end

# TODO
# Handle exceptions if it doesn't receive the needed args
# Handle exceptions if args are in the wrong order
# Confirm that it's sending to SendGrid?
# Some emails require arguments... Adjust 
# Later:
# => Multiple emails: http://blog.stevenocchipinti.com/2013/10/18/rake-task-with-an-arbitrary-number-of-arguments/
