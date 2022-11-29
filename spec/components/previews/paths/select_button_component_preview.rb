module Paths
  class SelectButtonComponentPreview < ViewComponent::Preview
    def default
      render(SelectButtonComponent.new(current_user: User.first, path: Path.first))
    end
  end
end
