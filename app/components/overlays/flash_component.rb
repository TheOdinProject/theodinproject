class Overlays::FlashComponent < ApplicationComponent
  DISSALLOWED_TYPES = %i[timedout].freeze

  FLASH_CLASSES = ClassVariants.build do
    variant type: :notice do
      slot :bg, class: 'bg-green-100'
      slot :icon, class: 'text-green-700'
      slot :text, class: 'text-green-900'
      slot :button,
           class: 'bg-green-100 text-green-600 hover:bg-green-200 focus:ring-green-600 focus:ring-offset-green-100'
    end

    variant type: :alert do
      slot :bg, class: 'bg-red-100'
      slot :icon, class: 'text-red-700'
      slot :text, class: 'text-red-900'
      slot :button, class: 'bg-red-100 text-red-600 hover:bg-red-200 focus:ring-red-600 focus:ring-offset-red-100'
    end
  end

  def initialize(type:, message:)
    @type = type.to_sym
    @message = message
  end

  def render?
    DISSALLOWED_TYPES.exclude?(type)
  end

  def icon_path
    {
      alert: 'icons/exclamation-circle-solid.svg',
      notice: 'icons/checkmark-circle-solid.svg',
    }.fetch(type)
  end

  def classes(slot)
    FLASH_CLASSES.render(slot, type: type)
  end

  private

  attr_reader :type, :message
end
