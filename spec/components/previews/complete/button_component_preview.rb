module Complete
  class ButtonComponentPreview < ViewComponent::Preview
    def default
      render(ButtonComponent.new(lesson: Lesson.first, current_user: User.first))
    end
  end
end
