require 'rails_helper'

RSpec.describe Flags::Actions::NotifyUser do
  let(:admin_user) { create(:admin_user) }
  let(:flag) { create(:flag) }

  describe '#perform' do
    context 'when successful' do
      it 'will discard the project submission in 7 days' do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.project_submission.reload.discard_at }.from(nil).to(7.days.from_now.all_day)
      end

      it 'creates a dead link notification' do
        deadlink_notification = Messages::DeadLink.new(flag)
        allow(Notifications::FlagNotification).to receive(:with).and_call_original

        described_class.perform(admin_user:, flag:)

        expect(Notifications::FlagNotification).to have_received(:with).with(
          flag:,
          title: deadlink_notification.title,
          message: deadlink_notification.content,
          url: deadlink_notification.url
        )
      end

      it "changes the flag action taken to 'notified_user'" do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.reload.taken_action }.from('pending').to('notified_user')
      end

      it 'resolves the flag' do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.reload.resolved? }.from(false).to(true)
      end

      it 'returns a successful result' do
        result = described_class.perform(admin_user:, flag:)

        expect(result).to be_success
        expect(result.message).to eq('Notification sent')
      end
    end
  end

  context 'when unsuccessful' do
    it 'returns an unsuccessful result' do
      allow(flag).to receive(:resolved?).and_return(false)

      expect(described_class.perform(admin_user:, flag:)).not_to be_success
    end
  end
end
