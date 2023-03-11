class Complete::IconComponent < ApplicationComponent
  def initialize(lesson:, current_user:)
    @lesson = lesson
    @current_user = current_user
  end

  def render?
    current_user.present?
  end

  private

  attr_reader :lesson, :current_user
end
