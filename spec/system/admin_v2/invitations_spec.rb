require 'rails_helper'

RSpec.describe 'Admin v2 invitations' do
  it 'can invite a new team member' do
    sign_in(create(:admin_user))

    # Create a new invitation
    visit admin_v2_team_path

    click_link('Invite new member')

    fill_in('Name', with: 'John Doe')
    fill_in('Email', with: 'john@example.com')
    click_button('Send invite')

    expect(page).to have_content('Invitation sent to john@example.com')
    expect(page).to have_content('John Doe')

    # Accept the invitation
    using_session('john') do
      open_email('john@example.com')
      expect(current_email.subject).to match(/The Odin Project Admin Invitation/)
      current_email.click_link('Accept invitation')

      expect(page).to have_content('Welcome to the team!')

      find(:test_id, 'password-field').fill_in(with: 'supersecretpassword')
      find(:test_id, 'password-confirmation-field').fill_in(with: 'supersecretpassword')
      click_button('Submit')

      expect(page).to have_current_path(admin_v2_dashboard_path)
    end
  end
end
