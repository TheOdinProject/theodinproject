class ProgressCircle::Component < ApplicationComponent
  renders_one :icon

  def initialize(percentage: 0, options: {})
    @percentage = percentage
    @options = options
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
