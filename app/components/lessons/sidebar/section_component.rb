module Lessons
  module Sidebar
    class SectionComponent < ApplicationComponent
      def initialize(section:, current_lesson:, current_user: nil)
        @section = section
        @current_lesson = current_lesson
        @current_user = current_user
      end

      private

      attr_reader :section, :current_lesson, :current_user

      def expanded?
        section.id == current_lesson.section_id
      end
    end
  end
end
