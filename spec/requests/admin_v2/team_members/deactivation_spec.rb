require 'rails_helper'

RSpec.describe 'Team member deactivation' do
  describe 'PUT #update' do
    context 'when signed in as an admin and the team member exists' do
      it 'deactivates the team member' do
        admin = create(:admin_user)
        active_admin = create(:admin_user, status: :active)

        sign_in(admin)

        expect do
          put admin_v2_team_member_deactivation_path(team_member_id: active_admin.id)
        end.to change { active_admin.reload.status }.from('active').to('deactivated')

        expect(response).to redirect_to(admin_v2_team_path)
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not deactivate the team member' do
        admin = create(:admin_user)
        sign_in(admin)

        put admin_v2_team_member_deactivation_path(team_member_id: 1002)

        expect(response).to redirect_to(admin_v2_team_path)
        expect(flash[:alert]).to eq('Team member not found')
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user)
        sign_in(user)

        expect do
          put admin_v2_team_member_deactivation_path(team_member_id: admin.id)
        end.not_to change { admin.reload.status }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
