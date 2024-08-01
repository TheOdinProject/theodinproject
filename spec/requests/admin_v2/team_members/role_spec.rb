require 'rails_helper'

RSpec.describe 'Team member role' do
  describe 'GET #edit' do
    context 'when signed in as an admin and the team member exists' do
      it 'renders the edit template' do
        admin = create(:admin_user)
        team_member = create(:admin_user)

        sign_in(admin)

        get edit_admin_v2_team_member_role_path(team_member)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'renders the edit template' do
        admin = create(:admin_user)

        sign_in(admin)

        get edit_admin_v2_team_member_role_path(team_member_id: 1002)

        expect(response).to redirect_to(admin_v2_team_path)
        expect(flash[:alert]).to eq('Team member not found')
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user)
        sign_in(user)

        get edit_admin_v2_team_member_role_path(admin)

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'when signed in as an admin and the team member exists' do
      it 'changes the the team members role' do
        admin = create(:admin_user)
        other_admin = create(:admin_user, role: 'moderator')

        sign_in(admin)

        expect do
          put admin_v2_team_member_role_path(other_admin), params: {
            admin_user: { role: 'core' },
            format: :turbo_stream
          }
        end.to change { other_admin.reload.role }.from('moderator').to('core')
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not reactivate the team member' do
        admin = create(:admin_user)
        sign_in(admin)

        put admin_v2_team_member_role_path(1002), params: {
          admin_user: { role: 'core' },
          format: :turbo_stream
        }

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
          put admin_v2_team_member_role_path(admin), params: {
            admin_user: { role: 'core' },
            format: :turbo_stream
          }
        end.not_to change { admin.reload.role }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
