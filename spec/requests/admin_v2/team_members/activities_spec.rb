require 'rails_helper'

RSpec.describe 'Team member activities' do
  describe 'GET #index' do
    context 'when signed in as an admin' do
      it 'renders the team activities page' do
        admin = create(:admin_user)

        sign_in(admin)
        get admin_v2_team_activities_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)

        sign_in(user)

        get admin_v2_team_activities_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
