require 'rails_helper'

RSpec.describe 'Admin V2 Sign in and sign out' do
  describe 'sign in' do
    context 'with valid credentials' do
      it 'signs the admin user in' do
        admin_user = create(:admin_user)

        visit admin_v2_root_path

        fill_in 'Email', with: admin_user.email
        fill_in 'Password', with: admin_user.password
        click_button 'Sign in'

        expect(page).to have_current_path(admin_v2_root_path)
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the user' do
        user = create(:user)

        visit admin_v2_root_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'

        expect(page).to have_current_path(new_admin_user_session_path)
      end
    end
  end

  describe 'sign out' do
    it 'signs the admin user out' do
      sign_in(create(:admin_user))

      visit admin_v2_root_path
      sleep 0.1 # it will not open the dropdown without this

      expect(page).to have_current_path(admin_v2_root_path)

      find(:test_id, 'admin-profile-dropdown').click
      find(:test_id, 'admin-sign-out-link').click

      expect(page).to have_current_path(new_admin_user_session_path)
    end
  end
end
