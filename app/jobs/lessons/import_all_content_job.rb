module Lessons
  class ImportAllContentJob < ApplicationJob
    def perform
      LessonContentImporter.import_all
    end
  end
end
