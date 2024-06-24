require 'rails_helper'

RSpec.describe Announcement do
  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_length_of(:message).is_at_most(100) }
  it { is_expected.to validate_presence_of(:expires_at) }
  it { is_expected.to allow_value('https://example.com').for(:learn_more_url) }
  it { is_expected.not_to allow_value('example.com').for(:learn_more_url) }
  it { is_expected.to allow_value(1.day.from_now).for(:expires_at) }
  it { is_expected.not_to allow_value(Time.zone.today).for(:expires_at) }
  it { is_expected.not_to allow_value(1.day.ago).for(:expires_at) }

  describe '.active' do
    it 'returns active announcements' do
      announcement_expires_tomorrow = create(:announcement, expires_at: 1.day.from_now)
      announcement_expires_next_week = create(:announcement, expires_at: 1.week.from_now)
      create(:announcement, :without_validations, expires_at: 1.hour.ago)

      expect(described_class.active).to contain_exactly(
        announcement_expires_tomorrow, announcement_expires_next_week
      )
    end
  end

  describe '.expired' do
    it 'returns expired messages' do
      create(:announcement, expires_at: 1.day.from_now)
      expired_announcement = create(:announcement, :without_validations, expires_at: 1.hour.ago)

      expect(described_class.expired).to contain_exactly(expired_announcement)
    end
  end

  describe '.showable_messages' do
    it 'returns messages that the user has not seen yet' do
      seen_unexpired_message = create(:announcement, expires_at: 1.week.from_now)
      unseen_unexpired_message = create(:announcement, expires_at: 1.day.from_now)
      create(:announcement, :without_validations, expires_at: 1.day.ago)

      disabled_announcement_ids = [seen_unexpired_message.id]

      expect(described_class.showable_messages(disabled_announcement_ids)).to contain_exactly(
        unseen_unexpired_message
      )
    end
  end

  describe '.ordered_by_recent' do
    it 'returns messages ordered by created_at in descending order' do
      announcement1 = create(:announcement, created_at: 1.day.ago)
      announcement2 = create(:announcement, created_at: 1.hour.ago)
      announcement3 = create(:announcement, created_at: 1.week.ago)

      expect(described_class.ordered_by_recent).to eq([announcement2, announcement1, announcement3])
    end
  end

  describe '.for_status' do
    context 'when status is active' do
      it 'returns active announcements' do
        active_announcement = create(:announcement, expires_at: 1.day.from_now)
        create(:announcement, :without_validations, expires_at: 1.day.ago)

        expect(described_class.for_status('active')).to contain_exactly(active_announcement)
      end
    end

    context 'when status is expired' do
      it 'returns expired announcements' do
        create(:announcement, expires_at: 1.day.from_now)
        expired_announcement = create(:announcement, :without_validations, expires_at: 1.day.ago)

        expect(described_class.for_status('expired')).to contain_exactly(expired_announcement)
      end
    end

    context 'when status is unknown' do
      it 'defaults to active announcements' do
        active_announcement = create(:announcement, expires_at: 1.day.from_now)

        expect(described_class.for_status('unknown')).to contain_exactly(active_announcement)
      end
    end
  end

  describe '#status' do
    context "when the announcement hasn't expired" do
      it 'returns active' do
        expect(build(:announcement, expires_at: 1.day.from_now).status).to eq(:active)
      end
    end

    context 'when the announcement has expired' do
      it 'returns expired' do
        expect(build(:announcement, expires_at: 1.day.ago).status).to eq(:expired)
      end
    end
  end

  describe '#active?' do
    context "when the announcement hasn't expired" do
      it 'returns true' do
        expect(build(:announcement, expires_at: 1.day.from_now)).to be_active
      end
    end

    context 'when the announcement is expired' do
      it 'returns false' do
        expect(build(:announcement, expires_at: 1.day.ago)).not_to be_active
      end
    end
  end
end
