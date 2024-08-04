require 'rails_helper'

RSpec.describe 'Admin user profile' do
  describe 'GET #edit' do
    context 'when signed in as an admin' do
      it 'renders the edit profile page' do
        admin = create(:admin_user)
        sign_in(admin)

        get edit_admin_profile_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the sign in page' do
        user = create(:user)
        sign_in(user)

        get edit_admin_profile_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when signed in as an admin and the form is valid' do
      it 'updates the admin user' do
        admin = create(:admin_user, email: 'old@example.com', name: 'Old Name')
        sign_in(admin)

        expect do
          put admin_profile_path, params: {
            profile: { email: 'new@example.com', name: 'New name' },
          }
        end.to change { admin.reload.name }.from('Old Name').to('New name')
          .and change { admin.reload.email }.from('old@example.com').to('new@example.com')

        expect(response).to redirect_to(edit_admin_profile_path)
      end
    end

    context 'when signed in as an admin and the form is invalid' do
      it 'returns an unprocessable entity response' do
        admin = create(:admin_user)
        sign_in(admin)

        put admin_profile_path, params: {
          profile: { email: '', name: '' },
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the sign in page' do
        put admin_profile_path, params: {
          admin_user: { email: 'test@example.com', name: 'Test' },
        }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
