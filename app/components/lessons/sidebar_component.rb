module Lessons
  class SidebarComponent < ApplicationComponent
    def initialize(course:, sections:, current_lesson:, current_user: nil)
      @course = course
      @sections = sections
      @current_lesson = current_lesson
      @current_user = current_user
    end

    private

    attr_reader :course, :sections, :current_lesson, :current_user

    def progress_percentage
      return if current_user.blank?

      course.progress_for(current_user).percentage
    end
  end
end
