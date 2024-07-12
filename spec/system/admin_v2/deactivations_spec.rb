require 'rails_helper'

RSpec.describe 'Admin V2 team members deactivations' do
  it 'deactivates a team member' do
    admin = create(:admin_user, status: :active)
    other_admin = create(:admin_user, status: :active, email: 'otheradmin@odin.com', password: 'password')

    sign_in(admin)

    visit admin_v2_team_path
    sleep 0.1 # dropdown animations can be slow

    within("#admin_user_#{other_admin.id}") do
      find(:test_id, 'dropdown-button').click
      click_link('Deactivate')
    end

    within('#deactivated_members') do
      expect(page).to have_content(other_admin.name)
    end

    using_session('other_admin') do
      visit new_admin_user_session_path

      fill_in 'Email', with: other_admin.email
      fill_in 'Password', with: other_admin.password
      click_button 'Sign in'

      expect(page).to have_current_path(new_admin_user_session_path)
      expect(page).to have_content('Your account is deactivated')
    end
  end
end
