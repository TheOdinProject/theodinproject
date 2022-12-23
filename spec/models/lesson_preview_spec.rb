require 'rails_helper'

RSpec.describe LessonPreview do
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(70_000) }

  describe '.expired' do
    it 'returns 2 expired lesson previews' do
      expired = create_list(:lesson_preview, 2, created_at: 1.month.ago)
      create_list(:lesson_preview, 2)

      expect(described_class.expired).to eq expired
    end
  end
end
