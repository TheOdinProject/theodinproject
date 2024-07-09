class Forms::DatePickerComponent < ApplicationComponent
  def initialize(name:, value:, min: nil, max: nil)
    @name = name
    @value = value
    @min = min
    @max = max
  end

  def min_date
    [min, value].compact.min
  end

  def max_date
    return max if max.present?

    Time.zone.today.to_s
  end

  private

  attr_reader :name, :value, :min, :max
end
