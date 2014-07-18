require "spec_helper"

describe TestMailer do

  describe 'email_one_person' do

    before :each do
      campaign = EmailCampaign.new
      campaign.name = "Test"
      campaign.method_name = "TestMailer.email_one_person"
      campaign.save
      FactoryGirl.create(:user, :email => "foo@bar.com")
      TestMailer.email_one_person
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

    it "records the email after it is sent" do
      expect(SentEmail.last.user).to eq(User.last)
    end

  end

end
