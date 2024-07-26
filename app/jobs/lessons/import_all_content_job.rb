module Lessons
  class ImportAllContentJob < ApplicationJob
    def perform
      Github::LessonContentImporter.import_all
    end
  end
end
