require 'rails_helper'

RSpec.describe 'User Notifications' do
  let!(:flag) { create(:flag, project_submission:) }
  let(:project_submission) { create(:project_submission, lesson:, user: submission_owner) }
  let(:lesson) { create(:lesson, is_project: true, accepts_submission: true, previewable: true) }
  let(:submission_owner) { create(:user, username: 'Simon Bell', email: 'simon@example.com', password: 'pa55word') }

  before do
    sign_in(create(:admin_user))
    visit admin_v2_flags_path

    within("#flag_#{flag.id}") do
      click_link('View')
    end

    click_button('Resolve flag')
    choose('action_taken_notified_user')
    click_button('Submit')

    sign_in(submission_owner)
  end

  context 'when the notification is unread' do
    it 'displays the unread notification icon in the users navbar' do
      visit root_path

      within(find(:test_id, 'navbar-notification-icon')) do
        expect(page).to have_css("span[data-test-id='unread-notifications']")
      end
    end

    it 'displays the notification to the user with an unread icon' do
      visit root_path

      find(:test_id, 'navbar-notification-icon').click

      within(find(:test_id, "notification-#{submission_owner.notifications.first.id}")) do
        expect(page).to have_css('[data-test-id="notification-unread-icon"]')
      end
    end
  end

  context 'when the notification is clicked' do
    it 'takes the user to the project lesson page' do
      visit root_path

      find(:test_id, 'navbar-notification-icon').click
      find(:test_id, "notification-#{submission_owner.notifications.first.id}").click

      expect(page).to have_current_path(lesson_path(lesson))
    end
  end

  context 'when the notification is read' do
    before do
      visit root_path

      find(:test_id, 'navbar-notification-icon').click
      find(:test_id, "notification-#{submission_owner.notifications.first.id}").click
    end

    it 'does not display the unread notification icon' do
      visit root_path

      within(find(:test_id, 'navbar-notification-icon')) do
        expect(page).not_to have_css("span[data-test-id='unread-notifications']")
      end
    end

    it 'displays the notification to the user with a read icon' do
      visit root_path

      find(:test_id, 'navbar-notification-icon').click

      within(find(:test_id, "notification-#{submission_owner.notifications.first.id}")) do
        expect(page).to have_css('[data-test-id="notification-read-icon"]')
      end
    end
  end
end
