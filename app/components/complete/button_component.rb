class Complete::ButtonComponent < ApplicationComponent
  def initialize(lesson_step:, current_user:)
    @lesson_step = lesson_step
    @current_user = current_user
  end

  private

  attr_reader :lesson_step, :current_user

  def text
    lesson_completed? ? 'Lesson Completed' : 'Mark Complete'
  end

  def lesson_completed?
    @lesson_completed ||= current_user.completed?(lesson_step.lesson)
  end
end
