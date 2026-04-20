module Lessons
  module Sidebar
    class LessonComponent < ApplicationComponent
      def initialize(lesson:, current_lesson:, current_user: nil)
        @lesson = lesson
        @current_lesson = current_lesson
        @current_user = current_user
      end

      private

      attr_reader :lesson, :current_lesson, :current_user

      def current?
        lesson.id == current_lesson.id
      end

      def icon_name
        lesson.is_project? ? 'wrench-screwdriver' : 'book'
      end
    end
  end
end
