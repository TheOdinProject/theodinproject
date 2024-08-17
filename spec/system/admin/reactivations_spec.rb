require 'rails_helper'

RSpec.describe 'Admin team members reactivations' do
  it 'reactivates a team member' do
    admin = create(:admin_user, :activated)
    deactivated_admin = create(:admin_user, :deactivated, email: 'deactivated@admin.com')

    sign_in(admin)

    visit admin_team_path
    sleep 0.1 # dropdown animations can be slow

    within("#admin_user_#{deactivated_admin.id}") do
      find(:test_id, 'dropdown-button').click

      accept_confirm do
        click_on('Reactivate')
      end
    end

    within('#team_members') do
      expect(page).to have_content(deactivated_admin.name)
    end

    using_session('deactivated_admin') do
      open_email('deactivated@admin.com')
      expect(current_email.subject).to match(/Joining The Odin Project Admin Team/)
      current_email.click_on('Join the team')

      find(:test_id, 'password-field').fill_in(with: 'supersecretpassword')
      find(:test_id, 'password-confirmation-field').fill_in(with: 'supersecretpassword')
      click_on('Submit')

      expect(page).to have_current_path(new_admin_two_factor_authentication_path)

      freeze_time do
        find(:test_id, 'otp-code-field').fill_in(with: otp_code_for(deactivated_admin.reload))
        click_on('Confirm')
      end

      expect(page).to have_current_path(admin_dashboard_path)
      expect(page).to have_content('Successfully enabled two factor authentication')
    end
  end
end
