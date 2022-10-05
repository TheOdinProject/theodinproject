module Lessons
  class TitleLinkComponentPreview < ViewComponent::Preview
    def with_lesson
      render(TitleLinkComponent.new(lesson: Lesson.first, lesson_number: 1))
    end

    def with_project
      render(TitleLinkComponent.new(lesson: Lesson.find(22), lesson_number: 22))
    end

    # @param lesson_id
    # @param lesson_number
    def with_param(lesson_id: 2, lesson_number: 2)
      lesson = Lesson.find_by(id: lesson_id) || Lesson.first
      render(TitleLinkComponent.new(lesson:, lesson_number:))
    end
  end
end
