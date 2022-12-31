class DividerComponentPreview < ViewComponent::Preview
  # @!group
  def with_text
    render DividerComponent.new(message: 'Dividing text!')
  end

  def without_text
    render DividerComponent.new
  end

  # @param message [String] text "The text to display in the divider"
  def with_param(message: 'Change me in params')
    render DividerComponent.new(message:)
  end
end
