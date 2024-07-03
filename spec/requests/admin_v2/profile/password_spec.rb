require 'rails_helper'

RSpec.describe 'Admin user profile password' do
  describe 'PATCH #update' do
    context 'when signed in as an admin and the form is valid' do
      it "updates the admin user's password" do
        admin = create(:admin_user, password: 'oldpassword')
        sign_in(admin)

        expect do
          put admin_v2_profile_password_path, params: {
            admin_user: {
              password: 'newpassword',
              password_confirmation: 'newpassword',
              current_password: 'oldpassword'
            }
          }
        end.to change { admin.reload.encrypted_password }

        expect(response).to redirect_to(edit_admin_v2_profile_path)
      end
    end

    context 'when signed in as an admin and the form is invalid' do
      it 'returns an unprocessable entity response' do
        admin = create(:admin_user, password: 'oldpassword')
        sign_in(admin)

        put admin_v2_profile_password_path, params: {
          admin_user: { password: 'new', password_confirmation: 'new', current_password: 'wrongpassword' },
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the sign in page' do
        put admin_v2_profile_password_path, params: {
          admin_user: { password: 'new', password_confirmation: 'new', current_password: 'wrongpassword' },
        }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
