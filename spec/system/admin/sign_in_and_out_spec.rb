require 'rails_helper'

RSpec.describe 'Admin sign in and sign out' do
  describe 'sign in' do
    context 'with valid credentials' do
      it 'signs the admin user in' do
        admin_user = create(:admin_user)

        visit admin_root_path

        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: admin_user.password
        click_button 'Sign in'

        expect(page).to have_current_path(admin_dashboard_path)
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the user' do
        user = create(:user)

        visit admin_root_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'

        expect(page).to have_current_path(new_admin_user_session_path)
      end
    end

    context 'when two factor authentication is enabled' do
      it 'prompts the user to enter a one time password and signs them in' do
        admin_user = create(:admin_user, :with_otp)

        visit admin_root_path

        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: admin_user.password
        click_button 'Sign in'

        expect(page).to have_content('Two factor authentication')
        fill_in 'Authentication code', with: otp_code_for(admin_user)
        click_button 'Sign in'

        expect(page).to have_current_path(admin_dashboard_path)
      end
    end

    context 'when the admin is deactivated' do
      it 'does not sign the admin in' do
        admin_user = create(:admin_user, :deactivated)

        visit admin_root_path

        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: admin_user.password
        click_button 'Sign in'

        expect(page).to have_current_path(new_admin_user_session_path)
        expect(page).to have_content('Your account is deactivated')
      end
    end
  end

  describe 'sign out' do
    it 'signs the admin user out' do
      sign_in(create(:admin_user))

      visit admin_root_path
      sleep 0.1 # it will not open the dropdown without this

      expect(page).to have_current_path(admin_root_path)

      find(:test_id, 'admin-profile-dropdown').click
      find(:test_id, 'admin-sign-out-link').click

      expect(page).to have_current_path(new_admin_user_session_path)
    end
  end
end
