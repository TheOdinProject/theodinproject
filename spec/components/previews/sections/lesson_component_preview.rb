module Sections
  class LessonComponentPreview < ViewComponent::Preview
    # @!group
    def with_lesson
      render(LessonComponent.new(lesson: Lesson.first, current_user: User.first))
    end

    def with_completed_lesson
      lesson = Lesson.first
      current_user = User.last
      complete_lesson!(lesson, current_user)
      render(LessonComponent.new(lesson: Lesson.first, current_user: User.last))
    end

    def with_project
      render(LessonComponent.new(lesson: Lesson.find(22), current_user: User.first))
    end

    # @param lesson_id
    def with_param(lesson_id: 6)
      lesson = Lesson.find_by(id: lesson_id) || Lesson.first
      render(LessonComponent.new(lesson:, current_user: User.first))
    end

    private

    def complete_lesson!(lesson, user)
      user.lesson_completions.create(
        lesson_id: lesson.id,
        lesson_identifier_uuid: lesson.identifier_uuid,
        course_id: lesson.course.id,
        path_id: lesson.course.path.id,
      )
    end
  end
end
