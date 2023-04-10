class Complete::IconComponent < ApplicationComponent
  def initialize(lesson:, current_user:, animate: false)
    @lesson = lesson
    @current_user = current_user
    @animate = animate
  end

  def render?
    current_user.present?
  end

  private

  attr_reader :lesson, :current_user, :animate

  def animation_class
    return unless animate

    'pulse-once'
  end
end
