module Lessons
  module Sidebar
    class CompletionIconComponent < ApplicationComponent
      def initialize(lesson:)
        @lesson = lesson
      end

      private

      attr_reader :lesson

      def color_class
        lesson.completed? ? 'text-teal-600' : 'text-gray-300 dark:text-gray-700'
      end

      def title
        lesson.completed? ? 'Lesson completed' : 'Lesson not completed'
      end
    end
  end
end
