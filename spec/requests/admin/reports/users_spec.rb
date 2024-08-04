require 'rails_helper'

RSpec.describe 'Reports - users' do
  describe 'GET #index' do
    context 'when signed in as an admin' do
      it 'renders the users report' do
        admin = create(:admin_user)
        sign_in(admin)

        get admin_reports_users_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the sign in page' do
        get admin_reports_users_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
