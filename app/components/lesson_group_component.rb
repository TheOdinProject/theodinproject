class LessonGroupComponent < ApplicationComponent
  def initialize(title:, lessons:, current_user: nil)
    @title = title
    @lessons = lessons
    @current_user = current_user
  end

  private

  attr_reader :title, :lessons, :current_user
end
