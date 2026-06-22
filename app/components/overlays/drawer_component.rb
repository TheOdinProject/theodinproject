class Overlays::DrawerComponent < ApplicationComponent
  BREAKPOINT_CLASSES = { lg: 'lg:hidden', xl: 'xl:hidden' }.freeze

  option :hook_class, reader: :private
  option :aria_label, reader: :private
  option :close_label, default: -> { 'Close sidebar' }, reader: :private
  option :breakpoint, reader: :private, default: -> { :lg }, type: lambda { |value|
    unless BREAKPOINT_CLASSES.key?(value)
      raise ArgumentError, "Unsupported breakpoint: #{value.inspect}. Must be one of #{BREAKPOINT_CLASSES.keys}"
    end

    value
  }

  private

  def breakpoint_class
    BREAKPOINT_CLASSES.fetch(breakpoint)
  end
end
