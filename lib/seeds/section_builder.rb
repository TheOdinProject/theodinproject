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
      @seeded_lessons = []

      yield self
      @section_step = build_section
      p "section_step -- #{section_step}"
    end

    def self.build(course_step, position, &)
      new(course_step, position, &)
    end

    def build_section
      @_section_step ||= @course_step.children.seed(:learnable_id, :learnable_type, :path_id) do |step|
        step.learnable = section
        step.path_id = @course_step.path_id
        step.position = position
        step.parent = @course_step
      end.first
    end

    def add_lessons(*lessons)
      p "add_lessons"
      p "section_step #{build_section}"
      @add_lessons ||= lessons.map do |lesson|
        LessonBuilder.build(build_section, lesson_position, lesson).tap do |seeded_lesson|
          seeded_lessons.push(seeded_lesson)
        end
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

    def lesson_position
      @@total_seeded_lessons[@course_step.course.identifier_uuid] += 1
    end
  end
end
# rubocop: enable Style/ClassVars
