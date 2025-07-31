# @hidden
# Not currently working, need to figure out how to pass helpers to the context
class FlashComponentPreview < ViewComponent::Preview
  def alert
    render(Overlays::FlashComponent.new(type: :alert, message: 'Alert!'))
  end

  def notice
    render(Overlays::FlashComponent.new(type: :notice, message: 'Notice!'))
  end
end
