# == Schema Information
#
# Table name: lesson_completions
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  user_id                :integer
#  created_at             :datetime
#  updated_at             :datetime
#  lesson_identifier_uuid :string           default(""), not null
#  course_id              :integer
#  path_id                :integer
#
require 'rails_helper'

RSpec.describe LessonCompletion do
  subject { described_class.new }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:lesson) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lesson_id) }

  describe '.created_today' do
    it 'returns lessons completed today' do
      lesson_completed_today = create(:lesson_completion, created_at: Time.zone.today)
      create(:lesson_completion, created_at: Time.zone.today - 2.days)

      expect(described_class.created_today).to contain_exactly(lesson_completed_today)
    end
  end
end
