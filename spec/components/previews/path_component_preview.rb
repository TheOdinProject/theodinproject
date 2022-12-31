class PathComponentPreview < ViewComponent::Preview
  # @!group
  def wide
    render(PathComponent.new(path: Path.first, style: :wide))
  end

  def column
    render(PathComponent.new(path: Path.first, style: :column))
  end

  # TODO: Currently will display the logged in / not logged in version based on global state.
  # Configure the lookbook layout to more easily inject a `current_user` for state based previews
end
