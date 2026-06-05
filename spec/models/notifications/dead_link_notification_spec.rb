require 'rails_helper'

RSpec.describe Notifications::DeadLinkNotification do
  subject(:notification) { described_class.new(flag) }

  let(:flag) do
    create(
      :flag,
      created_at: Time.zone.local(2021, 8, 1),
      project_submission: create(:project_submission, lesson:, user:)
    )
  end
  let(:lesson) { create(:lesson, title: 'test lesson1', previewable: true) }
  let(:user) { create(:user, username: 'testuser1') }

  describe '#deliver' do
    it 'creates a notification for the submission owner' do
      expect { notification.deliver }
        .to change { user.notifications.count }.from(0).to(1)
    end

    it 'builds the notification from the flag' do
      travel_to(Time.zone.local(2021, 8, 1)) { notification.deliver }

      expect(user.notifications.last).to have_attributes(
        title: 'One of your submissions has been flagged on 01 Aug 2021',
        message: 'Hey testuser1, your project test lesson1 has a broken link in your submission. ' \
                 'Please update it by 08 Aug 2021 so it doesn\'t get removed!',
        url: "/lessons/#{lesson.slug}"
      )
    end
  end
end
