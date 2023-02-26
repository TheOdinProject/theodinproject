module Sections
  class LessonComponent < ApplicationComponent
    def initialize(lesson:, current_user:, path:, classes: '')
      @lesson = lesson
      @current_user = current_user
      @path = path
      @classes = classes
    end

    private

    attr_reader :lesson, :current_user, :classes, :path

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
