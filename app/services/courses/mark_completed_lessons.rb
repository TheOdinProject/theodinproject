module Courses
  class MarkCompletedLessons
    def initialize(user:, lessons:)
      @user = user
      @lessons = lessons
    end

    def self.call(user:, lessons:)
      new(user:, lessons:).call
    end

    def call
      lessons.each do |lesson|
        next if completed_lesson_ids.exclude?(lesson.id)

        lesson.complete!
      end
    end

    private

    attr_reader :user, :lessons

    def completed_lesson_ids
      @completed_lesson_ids ||= user.lesson_completions.where(lesson: lessons).pluck(:lesson_id)
    end
  end
end
