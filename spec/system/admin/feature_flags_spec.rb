require 'rails_helper'

RSpec.describe 'Feature Flags' do
  context 'when an admin user' do
    before do
      user = create(:user, admin: true)
      sign_in(user)
    end

    it 'allows admins to enable and disable features' do
      visit home_path
      expect(page).to have_no_content('test feature is enabled')

      visit admin_dashboard_path
      find_by_id('utility_nav').click
      click_on 'Feature Flags'
      click_on 'Add Feature'
      fill_in 'value', with: 'test_feature'
      click_on 'Add Feature'
      click_on 'Fully Enable'

      visit home_path
      expect(page).to have_content('test feature is enabled')
    end
  end

  context 'when a learner user' do
    before do
      user = create(:user, admin: false)
      sign_in(user)
    end

    it 'does not allow learners to enable and disable features' do
      visit admin_dashboard_path

      expect(page).to have_content('Unauthorized Access!')
    end
  end
end
