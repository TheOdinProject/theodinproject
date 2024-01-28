require 'rails_helper'

RSpec.describe 'User Registrations' do
  describe 'POST #create' do
    around do |example|
      perform_enqueued_jobs do
        example.run
      end
    end

    context 'when the user is valid' do
      it 'sends the welcome email' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@example.com') })
        mail = ActionMailer::Base.deliveries.last

        expect(mail.to).to eq(['odin@example.com'])
        expect(mail.subject).to eq('Getting started with The Odin Project')
      end
    end

    context 'when the user is not valid' do
      it 'does not send the welcome email' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@') })

        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context 'when on a staging environment' do
      around do |example|
        ClimateControl.modify(STAGING: 'TRUE') do
          example.run
        end
      end

      it 'does not send the welcome email' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@example.com') })

        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end
