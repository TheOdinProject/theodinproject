require 'rails_helper'

RSpec.describe 'Live notifications', :non_transactional do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  context 'when on the notifications page' do
    it 'shows a new notification without a page refresh' do
      visit notifications_path
      expect(page).to have_content('No notifications yet')
      wait_for_cable_subscription

      deliver_notification

      within('#notifications') do
        expect(page).to have_content('has a broken link in your submission')
      end
    end
  end

  context 'when on another page' do
    it 'lights up the notification bell without a page refresh' do
      visit root_path
      wait_for_cable_subscription
      expect(page).to have_no_css("[data-test-id='unread-notifications']")

      deliver_notification

      expect(page).to have_css("[data-test-id='unread-notifications']")
    end
  end

  def wait_for_cable_subscription
    expect(page).to have_css('turbo-cable-stream-source[connected]', visible: :all)
  end

  def deliver_notification
    flag = create(:flag, project_submission: create(:project_submission, user:))
    Notifications::DeadLinkNotification.new(flag).deliver
  end
end
