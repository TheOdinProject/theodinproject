require 'rails_helper'

RSpec.describe 'Admin invitations' do
  describe 'GET #new' do
    context 'when an admin is signed in' do
      it 'renders the new invitation page' do
        admin = create(:admin_user)
        sign_in(admin)

        get new_admin_user_invitation_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when an admin is not signed in' do
      it 'redirects to the sign in page' do
        get new_admin_user_invitation_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end

    context 'when the admin is not authorized to invite other team members' do
      it 'redirects to the team page' do
        admin = create(:admin_user, role: 'moderator')

        sign_in(admin)

        get new_admin_user_invitation_path

        expect(response).to redirect_to(admin_team_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'POST #create' do
    context 'when an admin is signed in' do
      it 'invites a new admin user' do
        admin = create(:admin_user)
        sign_in(admin)

        expect do
          post admin_user_invitation_path, params: {
            admin_user: { email: 'test@example.com', name: 'Test', role: 'maintainer' },
            format: :turbo_stream
          }
        end.to change { AdminUser.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when an admin is not signed in' do
      it 'does not invite a new admin and redirects to the sign in page' do
        expect do
          post admin_user_invitation_path, params: {
            admin_user: { email: 'test@example.com', name: 'Test' },
          }
        end.not_to change { AdminUser.count }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end

    context 'when the admin is not authorized to invite other team members' do
      it 'redirects to the team page' do
        admin = create(:admin_user, role: 'moderator')

        sign_in(admin)

        post admin_user_invitation_path, params: {
          admin_user: { email: 'test@example.com', name: 'Test' },
        }

        expect(response).to redirect_to(admin_team_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'GET #edit' do
    context 'with a valid invitation token' do
      it 'renders the accept invitation page' do
        token = AdminUser.invite!(
          email: 'test@example.com',
          role: 'moderator',
          skip_invitation: true
        ).raw_invitation_token

        get accept_admin_user_invitation_path(invitation_token: token)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid invitation token' do
      it 'redirects to the sign in page' do
        AdminUser.invite!(
          email: 'test@example.com',
          role: 'moderator',
          skip_invitation: true
        ).raw_invitation_token

        get accept_admin_user_invitation_path(invitation_token: '17282')

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'when the invitation token is valid' do
      it 'signs the new admin in' do
        token = AdminUser.invite!(email: 'test@example.com', name: 'test', role: 'maintainer').raw_invitation_token

        put admin_user_invitation_path, params: {
          admin_user: { password: 'password', password_confirmation: 'password', invitation_token: token },
        }

        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when the invitation token is not valid' do
      it 'returns an unprocessable entity response' do
        AdminUser.invite!(
          email: 'test@example.com',
          name: 'test',
          role: 'maintainer',
        ).raw_invitation_token

        put admin_user_invitation_path, params: {
          admin_user: { password: 'password', password_confirmation: 'password', invitation_token: '123' },
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
