class Overlays::DrawerComponent < ApplicationComponent
  BREAKPOINT_CLASSES = { lg: 'lg:hidden', xl: 'xl:hidden' }.freeze

  def initialize(hook_class:, aria_label:, breakpoint: :lg, close_label: 'Close sidebar')
    unless BREAKPOINT_CLASSES.key?(breakpoint)
      raise ArgumentError, "Unsupported breakpoint: #{breakpoint.inspect}. Must be one of #{BREAKPOINT_CLASSES.keys}"
    end

    @hook_class = hook_class
    @breakpoint = breakpoint
    @close_label = close_label
    @aria_label = aria_label
  end

  private

  attr_reader :hook_class, :breakpoint, :close_label, :aria_label

  def breakpoint_class
    BREAKPOINT_CLASSES.fetch(breakpoint)
  end
end
