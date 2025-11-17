class LessonListComponent < ApplicationComponent
  def initialize(title:, lessons:, current_user:)
    @title = title
    @lessons = lessons
    @current_user = current_user
  end
end
