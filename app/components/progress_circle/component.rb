class ProgressCircle::Component < ApplicationComponent
  renders_one :icon

  style do
    variant type: :default do
      slot :text, class: 'text-xs sm:text-sm'
      slot :container_size, class: 'h-24 w-24 sm:h-28 sm:w-28'
      slot :icon_size, class: 'w-20 h-20 sm:p-2 sm:w-24 sm:h-24'
    end

    variant type: :small do
      slot :text, class: 'text-xs p-2'
      slot :container_size, class: 'h-24 w-24'
      slot :icon_size, class: 'w-24 h-24 p-3'
    end
  end

  def initialize(percentage: 0, options: {})
    @percentage = percentage
    @options = options
  end

  def variant
    size
  end

  private

  attr_reader :percentage, :options

  def size
    options.fetch(:size, :default)
  end

  def show_icon
    options.fetch(:show_icon, false)
  end

  def background_color
    options.fetch(:background_color, 'bg-white dark:bg-gray-900')
  end

  def show_icon_class
    if show_icon
      'visible'
    else
      'invisible'
    end
  end
end
