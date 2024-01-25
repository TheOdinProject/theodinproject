class SortComponent < ApplicationComponent
  def initialize(options:, selected: {}, data_attributes: {})
    @options = options
    @selected = selected
    @data_attributes = data_attributes
  end

  def selected_option
    options.find { |option| selected?(option) } || default_option
  end

  def default_option
    options.find { |option| option[:default] }
  end

  private

  attr_reader :options, :selected, :data_attributes

  def selected?(option)
    return option[:default] if selected.compact.empty?

    option[:value] == selected[:value] && option[:direction] == selected[:direction]
  end
end
