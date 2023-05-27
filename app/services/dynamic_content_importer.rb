# frozen_string_literal: true

class DynamicContentImporter
  CURRICULUM = 'theodinproject/curriculum'
  PATH_REF = 'ruby/test_folder_please_ignore'
  BRANCH = 'spike/frontmatter-in-lessons'

  class << self
    def import_all
      lessons.each do |lesson|
        lesson.persist
      rescue StandardError => e
        Rails.logger.error { "Error importing lesson: #{e}" }
        next
      end
    end

    private

    def resource
      @resource ||=  Octokit.contents(CURRICULUM, path: PATH_REF, query: { ref: BRANCH })
    end

    def lessons
      resource.map { |lesson| GhLesson.new(lesson) }
    end
  end
end
