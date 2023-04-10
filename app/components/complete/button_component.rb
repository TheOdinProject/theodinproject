class Complete::ButtonComponent < ApplicationComponent
  def initialize(lesson:, animate: false)
    @lesson = lesson
    @animate = animate
  end

  private

  attr_reader :lesson, :animate
end
