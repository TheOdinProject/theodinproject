class LessonsController < ApplicationController
  before_action :set_cache_control_header_to_no_store

  def show
    @lesson = Lesson.find(params[:id])

    if user_signed_in?
      Courses::MarkCompletedLessons.call(user: current_user, lessons: Array(@lesson))
    end
  end
end
