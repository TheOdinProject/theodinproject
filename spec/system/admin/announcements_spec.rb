require 'rails_helper'

RSpec.describe 'Admin announcements' do
  before do
    sign_in(create(:admin_user))
    visit admin_flags_path
  end

  context 'when creating a new announcement' do
    it 'displays the announcement message and expires at on the index page' do
      visit admin_announcements_path
      click_on('New announcement')

      fill_in :announcement_message, with: 'Test Message'
      fill_in :announcement_learn_more_url, with: 'https://example.com'
      fill_in :announcement_expires_at, with: 10.days.from_now.to_date.to_fs(:db)
      click_on('Save')

      visit admin_announcements_path
      expect(page).to have_content('Test Message')
      expect(page).to have_content(10.days.from_now.strftime('%B %d, %Y'))

      using_session('learner') do
        sign_in(create(:user))

        visit home_path
        expect(page).to have_content('Test Message')
      end
    end
  end

  context 'when editing an announcement' do
    it 'updates the announcement message' do
      announcement = create(:announcement, message: 'Test Message', expires_at: 10.days.from_now)
      visit admin_announcement_path(announcement)
      click_on('Edit')

      fill_in :announcement_message, with: 'Edited test Message'
      click_on('Save')

      visit admin_announcements_path
      expect(page).to have_content('Edited test Message')

      using_session('learner') do
        sign_in(create(:user))

        visit home_path
        expect(page).to have_content('Edited test Message')
      end
    end
  end

  context 'when deleting an announcement' do
    it 'removes the announcement' do
      announcement = create(:announcement, message: 'Test Message', expires_at: 10.days.from_now)
      visit admin_announcements_path
      expect(page).to have_content('Test Message')

      visit admin_announcement_path(announcement)

      accept_confirm do
        click_on('Delete')
      end

      expect(page).to have_current_path(admin_announcements_path)
      expect(page).to have_no_content('Test Message')

      using_session('learner') do
        sign_in(create(:user))

        visit home_path
        expect(page).to have_current_path(home_path)
        expect(page).to have_no_content('Test Message')
      end
    end
  end
end
