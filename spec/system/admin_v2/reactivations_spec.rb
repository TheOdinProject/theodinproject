require 'rails_helper'

RSpec.describe 'Admin V2 team members reactivations' do
  it 'deactivates a team member' do
    admin = create(:admin_user, status: :active)
    deactivated_admin = create(:admin_user, status: :deactivated, email: 'deactivated@admin.com')

    sign_in(admin)

    visit admin_v2_team_path
    sleep 0.1 # dropdown animations can be slow

    within("#admin_user_#{deactivated_admin.id}") do
      find(:test_id, 'dropdown-button').click
      click_link('Reactivate')
    end

    within('#active_members') do
      expect(page).to have_content(deactivated_admin.name)
    end

    using_session('deactivated_admin') do
      open_email('deactivated@admin.com')
      expect(current_email.subject).to match(/The Odin Project Admin Invitation/)
      current_email.click_link('Accept invitation')

      find(:test_id, 'password-field').fill_in(with: 'supersecretpassword')
      find(:test_id, 'password-confirmation-field').fill_in(with: 'supersecretpassword')
      click_button('Submit')

      expect(page).to have_current_path(admin_v2_dashboard_path)
    end
  end
end
