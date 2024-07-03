class Ui::BadgeComponent < ApplicationComponent
  def initialize(color:)
    @color = color
  end

  def color_classes
    case color
    when 'yellow'
      'bg-yellow-50 text-yellow-700 ring-yellow-600/20'
    when 'green'
      'bg-green-50 text-green-700 ring-green-600/20'
    else
      'bg-gray-50 text-gray-700 ring-gray-600/20'
    end
  end

  private

  attr_reader :color
end
