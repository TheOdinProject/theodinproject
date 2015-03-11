require 'spec_helper'

describe MailCampaignHelper do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let(:campaign) { FactoryGirl.create(:email_campaign) }
  
  describe '#check_campaign(method)' do
    it 'raises error if campaign is not registered' do
      expect{check_campaign("fake_method_name")}.to raise_error(/create a campaign/)
    end

    it 'returns valid campaign' do
      expect(check_campaign(campaign.method_name)).to eq(campaign)
    end
  end

  describe '#filter(users, campaign)' do
    # User who has unsubscribed_all flag should be filtered out
    let(:unsubscribed_user) {FactoryGirl.create(:user, unsubscribe_all: true) }
    # User who has unsubscribed from this category should be filtered out
    let(:choosy_user) { FactoryGirl.create(:user) }
    let!(:unsubscription) { FactoryGirl.create(:unsubscription, 
                            user_id: choosy_user.id, 
                            email_campaign_category_id: campaign.email_campaign_category_id)}
    # User who has already received this email should be filtered out
    let(:past_recipient) { FactoryGirl.create(:user) }
    let!(:sent_email) {FactoryGirl.create(:sent_email, 
                            user_id: past_recipient.id,
                            email_campaign_id: campaign.id)}


    it 'returns array of only valid users' do
      users = filter(User.all, campaign)
      expect(users[0]).to eq([user1, user2])
    end

    it 'returns array of only valid user emails' do
      users = filter(User.all, campaign)
      expect(users[1]).to eq([user1.email, user2.email])
    end
  end

  describe '#record(campaign, recipients)' do
    before do 
      recipients = [user1, user2]
      record(campaign, recipients)
    end

    it 'creates SentEmail records for each recipient' do
      expect(SentEmail.count).to eq(2)
    end

    specify 'SentEmail matches campaign' do
      expect(SentEmail.first.email_campaign).to eq(EmailCampaign.first)
    end

    specify 'SentEmail matches recipients' do
      expect(SentEmail.first.user).to eq(User.first)
    end
  end

  describe '#build_header(recipients)' do
    it 'creates valid SMTPAPI header for Sendgrid'      
    # Method throws runtime error when called in isolation
    # Headers can be tested in specific mailer tests
    # Sendgrid also provides a validator at
    # https://sendgrid.com/docs/API_Reference/SMTP_API/smtpapi_validator.html   
  end


end