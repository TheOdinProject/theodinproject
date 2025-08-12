require 'rails_helper'

RSpec.describe 'User Registrations' do
  describe 'POST #create' do
    around do |example|
      perform_enqueued_jobs do
        example.run
      end
    end

    context 'when the user is valid' do
      it 'redirects to the dashboard' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@example.com') })

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'when the user is not valid' do
      it 'renders the registration page again' do
        post user_registration_path(params: { user: attributes_for(:user, email: 'odin@') })

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
