class User::AvatarComponentPreview < ViewComponent::Preview
  def default
    current_user = User.first
    render(User::AvatarComponent.new(current_user:, classes: nil))
  end
end
