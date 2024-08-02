require 'rails_helper'

RSpec.describe 'Admin v2 invitations' do
  it 'invites a new team member' do
    sign_in(create(:admin_user))

    # Create a new invitation
    visit admin_v2_team_path

    click_link('Invite new member')

    fill_in('Name', with: 'John Doe')
    fill_in('Email', with: 'john@example.com')
    select('Core', from: 'Role')
    click_button('Send invite')

    expect(page).to have_content('Invitation sent to john@example.com')
    expect(page).to have_content('John Doe')

    # Accept the invitation
    using_session('john') do
      open_email('john@example.com')
      expect(current_email.subject).to match(/Joining The Odin Project Admin Team/)
      current_email.click_link('Join the team')

      expect(page).to have_content('Welcome to the team!')

      find(:test_id, 'password-field').fill_in(with: 'supersecretpassword')
      find(:test_id, 'password-confirmation-field').fill_in(with: 'supersecretpassword')
      click_button('Submit')

      expect(page).to have_current_path(new_admin_v2_two_factor_authentication_path)

      freeze_time do
        find(:test_id, 'otp-code-field').fill_in(with: otp_code_for(AdminUser.last))
        click_button('Confirm')
      end

      expect(page).to have_current_path(admin_v2_dashboard_path)
      expect(page).to have_content('Successfully enabled two factor authentication')
    end
  end

  it 'does not allow access if two factor authentication is not enabled' do
    sign_in(create(:admin_user, :activated))

    # Create a new invitation
    visit admin_v2_team_path

    click_link('Invite new member')

    fill_in('Name', with: 'John Doe')
    fill_in('Email', with: 'john@example.com')
    select('Core', from: 'Role')
    click_button('Send invite')

    expect(page).to have_content('Invitation sent to john@example.com')
    expect(page).to have_content('John Doe')

    # Accept the invitation
    using_session('john') do
      open_email('john@example.com')
      expect(current_email.subject).to match(/Joining The Odin Project Admin Team/)
      current_email.click_link('Join the team')

      expect(page).to have_content('Welcome to the team!')

      find(:test_id, 'password-field').fill_in(with: 'supersecretpassword')
      find(:test_id, 'password-confirmation-field').fill_in(with: 'supersecretpassword')
      click_button('Submit')

      expect(page).to have_current_path(new_admin_v2_two_factor_authentication_path)

      click_link('Dashboard')
      expect(page).to have_current_path(new_admin_v2_two_factor_authentication_path)
      expect(page).to have_content('Please enable two factor authentication before continuing.')
    end
  end
end
