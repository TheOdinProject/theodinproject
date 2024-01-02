class LessonsController < ApplicationController
  before_action :set_cache_control_header_to_no_store
  before_action :set_lesson
  before_action :set_bookmark

  def show
    if user_signed_in?
      Courses::MarkCompletedLessons.call(user: current_user, lessons: Array(@lesson))
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_bookmark
    return unless Feature.enabled?(:bookmarks, current_user)

    @bookmark = current_user.bookmarks.find_by(lesson_id: @lesson.id)
  end
end
