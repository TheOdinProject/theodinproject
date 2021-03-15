module Seeds
  class Course

    include SeedHelpers

    attr_accessor :identifier_uuid, :title, :description, :position

    def initialize(position, &block)
      @position = position
      yield self

      @seeded_sections = []
      @course = course
    end

    def self.create(position, &block)
      new(position, &block)
    end

    def add_section(&block)
      seeded_sections.push(
        Seeds::Section.create(course, section_position, &block)
      )
    end

    def course
      @course ||= ::Course.seed(:identifier_uuid) do |course|
        course.identifier_uuid = identifier_uuid
        course.title = title
        course.description = description
        course.position = position
      end.first
    end

    def delete_removed_seeds
      destroy_removed_seeds(course.lessons, seeded_lessons)
      destroy_removed_seeds(course.sections, seeded_sections.map(&:section))
    end

    private

    attr_reader :seeded_sections

    def section_position
      seeded_sections.size + 1
    end

    def seeded_lessons
      seeded_sections.map(&:seeded_lessons).flatten
    end
  end
end
