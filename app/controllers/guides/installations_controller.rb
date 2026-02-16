module Guides
  class InstallationsController < ApplicationController
    def index
      @lessons_by_path = Lesson
        .installation_lessons
        .sort_by { |lesson| [lesson.course.position, lesson.path.position] }
        .group_by(&:path)
    end
  end
end
