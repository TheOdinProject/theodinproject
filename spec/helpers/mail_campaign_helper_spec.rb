require 'spec_helper'

describe MailCampaignHelper do

  describe '#record(campaign, recipients)' do
    before do 
      3.times { FactoryGirl.create(:user) }
      recipients = User.all
      campaign = FactoryGirl.create(:email_campaign)
      record(campaign, recipients)
    end

    it 'creates SentEmail records for each recipient' do
      expect(SentEmail.count).to eq(3)
    end

    specify 'SentEmail matches campaign' do
      expect(SentEmail.first.email_campaign).to eq(EmailCampaign.first)
    end

    specify 'SentEmail matches recipients' do
      expect(SentEmail.first.user).to eq(User.first)
    end
  end

  describe '#build_header(recipients)' do
    it 'returns creates SMTPAPI header for Sendgrid' 
    # Best way to test is with Sendgrid validator
    # https://sendgrid.com/docs/API_Reference/SMTP_API/smtpapi_validator.html   
  end

end