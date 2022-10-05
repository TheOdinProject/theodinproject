module Complete
  class IconComponentPreview < ViewComponent::Preview
    def default
      render(IconComponent.new(lesson: Lesson.first, current_user: User.first))
    end
  end
end
