# frozen_string_literal: true

class Theme::MobileSwitcherComponent < ApplicationComponent
  def initialize(current_theme:)
    @current_theme = current_theme
  end

  private

  attr_reader :current_theme
end
