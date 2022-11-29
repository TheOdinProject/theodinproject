module Complete
  class ButtonComponentPreview < ViewComponent::Preview
    # @!group
    def uncompleted
      render(ButtonComponent.new(lesson: Lesson.first, current_user: User.find(21)))
    end

    def completed
      lesson = Lesson.first
      current_user = User.last
      complete_lesson!(lesson, User.last)
      render(ButtonComponent.new(lesson:, current_user:))
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
