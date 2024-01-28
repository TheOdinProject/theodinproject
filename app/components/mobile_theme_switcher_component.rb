# frozen_string_literal: true

class MobileThemeSwitcherComponent < ApplicationComponent
  def initialize(options:, selected: {})
    @options = options
    @selected = selected
  end

  def text
    "#{@selected[:value].capitalize} mode"
  end

  def icon
    case @selected[:value]
    when 'dark'
      'moon'
    when 'light'
      'sun'
    else
      'computer-desktop'
    end
  end

  private

  attr_reader :options, :selected

  def selected?(option)
    return option[:default] if selected.compact.empty?

    option[:value] == params[:theme]
  end
end
