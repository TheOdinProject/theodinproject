require 'rails_helper'

RSpec.describe 'Two factor authentication' do
  describe 'GET #new' do
    context 'when two factor authentication is already enabled' do
      it 'redirects to the dashboard' do
        admin = create(:admin_user, otp_required_for_login: true)
        sign_in(admin)

        get new_admin_two_factor_authentication_path

        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when two factor authentication is not enabled' do
      it 'generates a two factor secret and renders the new view' do
        admin = create(:admin_user, otp_required_for_login: false)
        sign_in(admin)

        expect do
          get new_admin_two_factor_authentication_path
        end.to change { admin.reload.otp_secret }.from(nil)

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'when the otp code is valid' do
      it 'enables two factor authentication for the admin' do
        admin = create(:admin_user, :pending, otp_required_for_login: false)
        allow(admin).to receive(:validate_and_consume_otp!).and_return(true)

        sign_in(admin)

        expect do
          post admin_two_factor_authentication_path, params: {
            two_fa: { otp_code: 'code' },
          }
        end.to change { admin.reload.otp_required_for_login }.from(false).to(true)

        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context 'when the otp code is not valid' do
      it 're-renders the new' do
        admin = create(:admin_user, otp_required_for_login: false)
        allow(admin).to receive(:validate_and_consume_otp!).and_return(false)

        sign_in(admin)

        post admin_two_factor_authentication_path, params: {
          two_fa: { otp_code: 'wrong-code' },
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('Incorrect Code')
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
