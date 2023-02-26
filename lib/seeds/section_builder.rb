# rubocop: disable Style/ClassVars
require './lib/seeds/lesson_builder'

module Seeds
  class SectionBuilder
    @@total_seeded_lessons = Hash.new(0)

    attr_accessor :identifier_uuid, :title, :description, :position
    attr_reader :seeded_lessons

    def initialize(course_step, position)
      @course_step = course_step
      @position = position

      yield self
      @section_step = build_section_step
    end

    def self.build(course_step, position, &)
      new(course_step, position, &)
    end

    def build_section_step
      @_section_step ||= @course_step.children.seed(:learnable_id, :learnable_type, :path_id) do |step|
        step.learnable_id = section.id
        step.learnable_type = 'Section'
        step.path_id = @course_step.path_id
        step.position = position
        step.parent = @course_step
      end.first
    end

    def add_lessons(*lessons)
      @add_lessons ||= lessons.map do |lesson|
        LessonBuilder.build(build_section_step, lesson_position, lesson)
      end
    end

    def section
      @_section ||= Section.seed(:identifier_uuid) do |section|
        section.identifier_uuid = identifier_uuid
        section.title = title
        section.description = description
      end.first
    end

    private

    attr_reader :section_step

    def delete_removed_seeds
      destroy_removed_seeds(persisted_collection: course.sections, seeded_collection: seeded_sections.map(&:section))
    end

    def lesson_position
      @@total_seeded_lessons[@course_step.course.identifier_uuid] += 1
    end
  end
end
# rubocop: enable Style/ClassVars
