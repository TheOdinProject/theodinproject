require './lib/seeds/helpers'
require './lib/seeds/section_builder'

module Seeds
  class CourseBuilder
    include Seeds::Helpers

    attr_accessor :identifier_uuid, :title, :description, :position, :show_on_homepage, :badge_uri

    def initialize(path, position)
      @path = path
      @position = position
      @seeded_sections = []

      yield self
      @course = course
      @course_step = course_step
    end

    def self.build(path, position, &)
      new(path, position, &)
    end

    def add_section(&)
      Seeds::SectionBuilder.build(course_step, section_position, &).tap do |section|
        seeded_sections.push(section)
      end
    end

    # rubocop:disable Metrics/AbcSize
    def course_step
      # puts "hello"
      @course_step ||= Step.seed(:learnable_id, :learnable_type, :path_id) do |step|
        step.learnable = course
        step.path_id = path.id
        step.position = position
      end.first
    end
    # rubocop:enable Metrics/AbcSize

    def delete_removed_seeds
      # destroy_removed_seeds(course_step.lessons, seeded_lessons)
      destroy_removed_seeds(course.sections, seeded_sections.map(&:section))
    end

    def course
      @course ||= ::Course.seed(:identifier_uuid) do |course|
        course.identifier_uuid = identifier_uuid
        course.title = title
        course.description = description
        course.show_on_homepage = show_on_homepage || false
        course.badge_uri = badge_uri
      end.first
    end

    private

    attr_reader :seeded_sections, :path

    def section_position
      seeded_sections.size + 1
    end

    def seeded_lessons
      seeded_sections.map(&:seeded_lessons).flatten
    end
  end
end
