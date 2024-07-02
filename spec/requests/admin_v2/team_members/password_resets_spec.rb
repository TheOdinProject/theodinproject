require 'rails_helper'

RSpec.describe 'Team member password resets' do
  describe 'POST #create' do
    context 'when signed in as an admin and the team member exists' do
      it 'sends a password reset email' do
        admin = create(:admin_user)
        other_admin = create(:admin_user)
        sign_in(admin)

        expect do
          post admin_v2_team_member_password_resets_path(other_admin)
        end.to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(response).to redirect_to(admin_v2_team_path)
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not send a password reset email' do
        admin = create(:admin_user)
        sign_in(admin)

        expect do
          post admin_v2_team_member_password_resets_path(team_member_id: 101)
        end.not_to change { ActionMailer::Base.deliveries.count }

        expect(response).to redirect_to(admin_v2_team_path)
        expect(flash[:alert]).to eq('Team member not found')
      end
    end

    context 'when not signed in as an admin' do
      it 'does not send a password reset email and redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user)
        sign_in(user)

        expect do
          post admin_v2_team_member_password_resets_path(admin)
        end.not_to change { ActionMailer::Base.deliveries.count }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
