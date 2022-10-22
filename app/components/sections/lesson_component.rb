module Sections
  class LessonComponent < ApplicationComponent
    def initialize(lesson:, current_user:, classes: '')
      @lesson = lesson
      @current_user = current_user
      @classes = classes
    end

    private

    attr_reader :lesson, :current_user, :classes

    def title
      if lesson.is_project?
        "Project: #{lesson.title}"
      else
        lesson.title
      end
    end

    def icon
      if lesson.is_project?
        'wrench-screwdriver'
      else
        'book'
      end
    end

    def icon_title
      return 'Project' if lesson.is_project?

      'Lesson'
    end
  end
end
