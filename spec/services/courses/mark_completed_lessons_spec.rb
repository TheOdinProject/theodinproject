require 'rails_helper'

RSpec.describe Courses::MarkCompletedLessons do
  describe '#call' do
    context 'when the lesson is included in users lesson completions' do
      it 'marks the lesson as completed' do
        user = create(:user)
        lesson = create(:lesson)
        create(:lesson_completion, lesson:, user:)

        described_class.call(user:, lessons: [lesson])

        expect(lesson.completed?).to be(true)
      end
    end

    context 'when lesson is not included in users lesson completions' do
      it 'does not mark the lesson as complete' do
        user = create(:user)
        lesson = create(:lesson)
        other_lesson = create(:lesson)
        create(:lesson_completion, lesson: other_lesson, user:)

        described_class.call(user:, lessons: [lesson])

        expect(lesson.completed?).to be(false)
      end
    end
  end
end
