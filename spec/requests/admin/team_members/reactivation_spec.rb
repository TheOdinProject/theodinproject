require 'rails_helper'

RSpec.describe 'Team member reactivation' do
  describe 'PUT #update' do
    context 'when signed in as an admin and the team member exists' do
      before do
        Mail::TestMailer.deliveries.clear
      end

      it 'reactivates the team member' do
        admin = create(:admin_user)
        deactivated_admin = create(:admin_user, :deactivated)

        sign_in(admin)

        expect do
          put admin_team_member_reactivation_path(deactivated_admin)
        end.to change { deactivated_admin.reload.status }.from('deactivated').to('pending_reactivation')

        expect(response).to redirect_to(admin_team_path)
      end

      it 'resets the admins two factor credentials' do
        admin = create(:admin_user)
        deactivated_admin = create(:admin_user, :deactivated, otp_secret: 'secret')
        sign_in(admin)

        expect do
          put admin_team_member_reactivation_path(deactivated_admin)
        end.to change { deactivated_admin.reload.otp_secret }
      end

      it 'sends an invitation email to the team member' do
        admin = create(:admin_user)
        deactivated_admin = create(:admin_user, :deactivated, email: 'deactivated@odin.com')
        sign_in(admin)

        put admin_team_member_reactivation_path(team_member_id: deactivated_admin.id)

        # rubocop:disable RSpec/NamedSubject
        expect(subject).to have_sent_email.to(deactivated_admin.email)
        expect(subject).to have_sent_email.with_subject('Joining The Odin Project Admin Team')
        # rubocop:enable RSpec/NamedSubject
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not reactivate the team member' do
        admin = create(:admin_user)
        sign_in(admin)

        put admin_team_member_reactivation_path(team_member_id: 1002)

        expect(response).to redirect_to(admin_team_path)
        expect(flash[:alert]).to eq('Team member not found')
      end
    end

    context 'when the admin is not authorized to reactivate other team members' do
      it 'redirects to the team page' do
        admin = create(:admin_user, role: 'moderator')
        deactivated_admin = create(:admin_user, :deactivated)
        sign_in(admin)

        expect do
          put admin_team_member_reactivation_path(deactivated_admin)
        end.not_to change { deactivated_admin.reload.status }

        expect(response).to redirect_to(admin_team_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user)
        sign_in(user)

        expect do
          put admin_team_member_reactivation_path(admin)
        end.not_to change { admin.reload.status }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
