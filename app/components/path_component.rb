class PathComponent < ApplicationComponent
  def initialize(path:, style: :wide, tagline: nil, classes: nil)
    @path = path
    @style = style
    @tagline = tagline
    @classes = classes
  end

  private

  attr_reader :path, :user, :style, :tagline, :classes

  def before_render
    @user = helpers.current_user
  end

  def wide?
    style == :wide
  end

  def column?
    style == :column
  end
end
