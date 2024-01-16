class Theme::SwitcherComponent < ApplicationComponent
  def initialize(current_theme:, type: :default)
    @current_theme = current_theme
    @type = type
  end

  def text
    "#{current_theme.name.capitalize} mode"
  end

  def icon_only?
    type == :icon_only
  end

  def mobile?
    type == :mobile
  end

  private

  attr_reader :current_theme, :type
end
