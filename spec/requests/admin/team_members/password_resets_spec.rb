require 'rails_helper'

RSpec.describe 'Team member password resets' do
  before do
    Mail::TestMailer.deliveries.clear
  end

  describe 'POST #create' do
    context 'when signed in as an admin and the team member exists' do
      it 'sends a password reset email' do
        admin = create(:admin_user)
        other_admin = create(:admin_user)
        sign_in(admin)

        post admin_team_member_password_resets_path(other_admin)

        expect(subject).to have_sent_email.to(other_admin.email) # rubocop:disable RSpec/NamedSubject
        expect(response).to redirect_to(admin_team_path)
      end
    end

    context 'when signed in as an admin and the team member does not exist' do
      it 'does not send a password reset email' do
        admin = create(:admin_user)
        sign_in(admin)

        post admin_team_member_password_resets_path(team_member_id: 101)

        expect(subject).not_to have_sent_email # rubocop:disable RSpec/NamedSubject
        expect(response).to redirect_to(admin_team_path)
        expect(flash[:alert]).to eq('Team member not found')
      end
    end

    context 'when not signed in as an admin' do
      it 'does not send a password reset email and redirects to the admin sign in page' do
        user = create(:user)
        admin = create(:admin_user)
        sign_in(user)

        post admin_team_member_password_resets_path(admin)

        expect(subject).not_to have_sent_email # rubocop:disable RSpec/NamedSubject
        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
