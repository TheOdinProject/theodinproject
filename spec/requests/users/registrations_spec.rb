require 'rails_helper'

RSpec.describe 'User Registrations' do
  describe 'POST #create' do
    before do
      Mail::TestMailer.deliveries.clear
    end

    around do |example|
      perform_enqueued_jobs do
        example.run
      end
    end

    context 'when the user is valid' do
      it 'sends the welcome email' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@example.com') })

        # rubocop:disable RSpec/NamedSubject
        expect(subject).to have_sent_email.to('odin@example.com')
        expect(subject).to have_sent_email.with_subject('Getting started with The Odin Project')
        # rubocop:enable RSpec/NamedSubject
      end
    end

    context 'when the user is not valid' do
      it 'does not send the welcome email' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@') })

        expect(subject).not_to have_sent_email # rubocop:disable RSpec/NamedSubject
      end
    end

    context 'when on a staging environment' do
      around do |example|
        Dotenv.modify(STAGING: 'TRUE') do
          example.run
        end
      end

      it 'does not send the welcome email' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@example.com') })

        expect(subject).not_to have_sent_email # rubocop:disable RSpec/NamedSubject
      end
    end
  end
end
