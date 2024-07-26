require 'rails_helper'

RSpec.describe 'Team members' do
  describe 'GET #index' do
    context 'when signed in as an admin' do
      it 'renders the team members page' do
        sign_in(create(:admin_user))

        get admin_v2_team_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        sign_in(create(:user))

        get admin_v2_team_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when signed in as an admin and the team member is pending' do
      it 'deletes the team member' do
        pending_admin = create(:admin_user, :pending)

        sign_in(create(:admin_user))

        expect do
          delete admin_v2_team_member_path(pending_admin)
        end.to change { AdminUser.count }.by(-1)

        expect(response).to redirect_to(admin_v2_team_path)
      end
    end

    context 'when signed in as an admin and the team member is not pending' do
      it 'does not delete the team member' do
        active_admin = create(:admin_user, :activated)

        sign_in(create(:admin_user))

        expect do
          delete admin_v2_team_member_path(active_admin)
        end.not_to change { AdminUser.count }

        expect(response).to redirect_to(admin_v2_team_path)
        expect(flash[:alert]).to eq('Only pending team members can be removed')
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user)
        sign_in(user)

        expect do
          delete admin_v2_team_member_path(admin)
        end.not_to change { AdminUser.count }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
