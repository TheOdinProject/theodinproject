class Alerts::FlashComponent < ApplicationComponent
  def initialize(type:, message:)
    @type = type.to_sym
    @message = message
  end

  def icon_path
    {
      alert: 'icons/exclamation-circle-solid.svg',
      notice: 'icons/checkmark-circle-solid.svg',
      timedout: 'icons/exclamation-circle-solid.svg'
    }.fetch(type)
  end

  private

  attr_reader :type, :message
end
