class ContentContainerComponentPreview < ViewComponent::Preview
  # @!group
  # @param content [String] text "The content to be contained"
  def default(content: 'This is where the content goes')
    render ContentContainerComponent.new do
      content
    end
  end
end
