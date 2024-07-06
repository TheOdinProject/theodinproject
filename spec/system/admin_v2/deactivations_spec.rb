require 'rails_helper'

RSpec.describe 'Admin V2 team members deactivations' do
  it 'deactivates a team member' do
    admin = create(:admin_user, status: :active)
    other_admin = create(:admin_user, status: :active)

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
  end
end
