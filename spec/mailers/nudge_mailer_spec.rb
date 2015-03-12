require "spec_helper"

describe NudgeMailer do

  describe '#inactive_one_month' do
    let!(:inactive_user) { FactoryGirl.create(:user, last_sign_in_at: Time.now - 5.weeks) }
    let!(:campaign) { FactoryGirl.create(:email_campaign, method_name: "inactive_one_month") }
    let(:email) { ActionMailer::Base.deliveries.last }

    it 'only goes to users inactive for one month' do
      active_user = FactoryGirl.create(:user, last_sign_in_at: Time.now)
      semi_active_user = FactoryGirl.create(:user, last_sign_in_at: Time.now - 1.week)
      active_user = FactoryGirl.create(:user, last_sign_in_at: Time.now)
      unconfirmed_user = FactoryGirl.create(:user, confirmed_at: nil)
      NudgeMailer.inactive_one_month
      # Sendgrid header determines actual recipients of email
      sendgrid_header = ActiveSupport::JSON.decode(email.header['X-SMTPAPI'].value)
      puts sendgrid_header["to"]
      expect(sendgrid_header["to"]).to eq(["#{inactive_user.email}"])
    end

    context 'After email is sent' do
      before { NudgeMailer.inactive_one_month }

      it 'records sent emails' do
        expect(SentEmail.last).to eq(SentEmail.where(
          "user_id = ? AND email_campaign_id = ? AND created_at >= ?", 
          inactive_user.id, campaign.id, Time.now - 1.minute).first)
      end

      it 'does not resend email to previous recipients' do
        expect{NudgeMailer.inactive_one_month}.to change{
          ActionMailer::Base.deliveries.length}.by(0)
      end

      it 'does not create duplicate sent emails' do
        expect{NudgeMailer.inactive_one_month}.to change{SentEmail.count}.by(0)
      end

      it 'has unsubscribe link in message body' do
        expect(email).to have_link('here')
      end

      specify 'link goes to generic unsubscribe page' do
        email = ActionMailer::Base.deliveries.last.encoded   # Encoded to capture link
        link = email.match(/href="(.*unsubscribe.*)"/)[1]
        visit link
        expect(page).to have_selector('div', text: "Unsubscribe")
      end
    end
  end
end