module Seeds
  class Section

    attr_accessor :identifier_uuid, :title, :description, :position
    attr_reader :seeded_lessons

    def initialize(course, position, &block)
      @course = course
      @position = position
      @seeded_lessons = []

      yield self
      @section = section
    end

    def self.create(course, position, &block)
      new(course, position, &block)
    end

    def section
      @section ||= course.sections.seed(:identifier_uuid) do |section|
        section.identifier_uuid = identifier_uuid
        section.title = title
        section.description = description
        section.position = position
      end.first
    end

    def add_lessons(*lessons_attrs)
      @lessons ||=
      lessons_attrs.map.with_index do |lesson_attrs, index|
          position = index + 1

          seeded_lessons.push(
            section.lessons.seed(:identifier_uuid, :section_id) do |lesson|
              lesson.identifier_uuid = lesson_attrs.fetch(:identifier_uuid)
              lesson.title = lesson_attrs.fetch(:title)
              lesson.description = lesson_attrs.fetch(:description)
              lesson.url = lesson_attrs.fetch(:url)
              lesson.section_id = section.id
              lesson.is_project = lesson_attrs.fetch(:is_project, false)
              lesson.accepts_submission = lesson_attrs.fetch(:accepts_submission, false)
              lesson.has_live_preview = lesson_attrs.fetch(:has_live_preview, false)
              lesson.position = position
            end
          )
        end
    end

    private

    attr_reader :course, :position
  end
end
