require 'rails_helper'

RSpec.describe 'Team member reactivation' do
  describe 'PUT #update' do
    context 'when signed in as an admin and the team member exists' do
      it 'reactivates the team member' do
        admin = create(:admin_user)
        deactivated_admin = create(:admin_user, status: :deactivated)

        sign_in(admin)

        expect do
          put admin_v2_team_member_reactivation_path(team_member_id: deactivated_admin.id)
        end.to change { deactivated_admin.reload.status }.from('deactivated').to('active')

        expect(response).to redirect_to(admin_v2_team_path)
      end

      it 'sends an invitation email to the team member' do
        admin = create(:admin_user)
        deactivated_admin = create(:admin_user, status: :deactivated, email: 'deactivated@odin.com')
        sign_in(admin)

        expect do
          put admin_v2_team_member_reactivation_path(team_member_id: deactivated_admin.id)
        end.to change { ActionMailer::Base.deliveries.count }

        mailer = ActionMailer::Base.deliveries.last

        expect(mailer.to).to eq(['deactivated@odin.com'])
        expect(mailer.subject).to eq('The Odin Project Admin Invitation')
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not reactivate the team member' do
        admin = create(:admin_user)
        sign_in(admin)

        put admin_v2_team_member_reactivation_path(team_member_id: 1002)

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
          put admin_v2_team_member_reactivation_path(team_member_id: admin.id)
        end.not_to change { admin.reload.status }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
