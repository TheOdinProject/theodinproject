require 'rails_helper'

RSpec.describe 'Team member two factor reset' do
  describe 'PUT #update' do
    context 'when signed in as an admin and the team member exists' do
      it 'resets the admins two factor credentials' do
        admin = create(:admin_user)
        other_admin = create(:admin_user, otp_secret: 'secret')
        sign_in(admin)

        expect do
          put admin_v2_team_member_two_factor_reset_path(other_admin)
        end.to change { other_admin.reload.otp_secret }.to(nil)
          .and change { other_admin.reload.status }.from('activated').to('pending')

        expect(response).to redirect_to(admin_v2_team_path)
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not reset the admins two factor credentials' do
        admin = create(:admin_user)
        sign_in(admin)

        put admin_v2_team_member_two_factor_reset_path(team_member_id: 1009)

        expect(response).to redirect_to(admin_v2_team_path)
        expect(flash[:alert]).to eq('Team member not found')
      end
    end

    context 'when the admin is not authorized to reset 2fa' do
      it 'redirects to the team page' do
        admin = create(:admin_user, role: 'maintainer')
        other_admin = create(:admin_user)
        sign_in(admin)

        expect do
          put admin_v2_team_member_two_factor_reset_path(other_admin)
        end.not_to change { other_admin.reload.otp_secret }

        expect(response).to redirect_to(admin_v2_team_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end

    context 'when not signed in as an admin' do
      it 'does not reset the admins two factor credentials and redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user, otp_secret: 'secret')
        sign_in(user)

        expect do
          put admin_v2_team_member_two_factor_reset_path(admin)
        end.not_to change { admin.reload.otp_secret }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
