require 'rails_helper'

RSpec.describe LessonCompletion do
  subject { described_class.new }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to belong_to(:course).optional }
  it { is_expected.to belong_to(:path).optional }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lesson_id) }

  describe '.created_on' do
    it 'returns lessons completions created on the given date' do
      lesson_completed_yesterday = create(:lesson_completion, created_at: Time.zone.yesterday)
      create(:lesson_completion, created_at: Time.zone.today)
      create(:lesson_completion, created_at: Time.zone.tomorrow)
      create(:lesson_completion, created_at: Time.zone.yesterday - 1.day)

      expect(described_class.completed_on(Time.zone.yesterday)).to contain_exactly(lesson_completed_yesterday)
    end
  end
end
