require 'rails_helper'

RSpec.describe Notification do
  describe '.newest_first' do
    it 'orders notifications by most recently created first' do
      oldest = create(:notification, created_at: 2.days.ago)
      newest = create(:notification, created_at: 1.hour.ago)
      middle = create(:notification, created_at: 1.day.ago)

      expect(described_class.newest_first).to eq([newest, middle, oldest])
    end
  end
end
