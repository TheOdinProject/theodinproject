require 'rails_helper'

RSpec.describe ExpireAnnouncementsJob do
  subject(:job) { described_class.new }

  describe '#perform' do
    it 'updates active announcements that have expired' do
      active_unexpired = create(:announcement, expires_at: 1.day.from_now)
      active_expired = create(:announcement, :without_validations, expires_at: 1.day.ago)
      already_expired = create(:announcement, :without_validations, status: :expired, expires_at: 1.day.ago)

      job.perform

      expect(active_unexpired.reload.status).to eq('active')
      expect(active_expired.reload.status).to eq('expired')
      expect(already_expired.reload.status).to eq('expired')
    end
  end
end
