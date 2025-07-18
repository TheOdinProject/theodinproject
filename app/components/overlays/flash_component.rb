class Overlays::FlashComponent < ApplicationComponent
  DISSALLOWED_TYPES = %i[timedout].freeze

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

  private

  attr_reader :type, :message
end
