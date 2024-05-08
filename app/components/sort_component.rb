class SortComponent < ApplicationComponent
  def initialize(options:, selected: {})
    @options = options
    @selected = selected
  end

  def selected_option
    options.find { |option| selected?(option) } || default_option
  end

  def default_option
    options.find { |option| option[:default] }
  end

  private

  attr_reader :options, :selected

  def selected?(option)
    return option[:default] if selected.compact.empty?

    option[:value] == selected[:value] && option[:direction] == selected[:direction]
  end
end
