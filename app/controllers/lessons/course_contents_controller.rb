module Lessons
  class CourseContentsController < ApplicationController
    before_action :set_cache_control_header_to_no_store

    def show
      @lesson = Lesson.find(params[:lesson_id])
      @course = @lesson.course
      @sections = @course.sections.includes(:lessons)

      return unless user_signed_in?

      Courses::MarkCompletedLessons.call(
        user: current_user,
        lessons: @sections.flat_map(&:lessons),
      )
    end
  end
end
