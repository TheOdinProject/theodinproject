require 'rails_helper'

RSpec.describe 'Reports - Path' do
  describe 'GET #show' do
    context 'when signed in as an admin' do
      it 'renders the path report' do
        admin = create(:admin_user)
        path = create(:path)

        sign_in(admin)
        get admin_v2_reports_path_path(path)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the sign in page' do
        path = create(:path)

        get admin_v2_reports_path_path(path)

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
