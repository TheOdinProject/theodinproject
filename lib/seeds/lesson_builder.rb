module Seeds
  class LessonBuilder
    def initialize(section_step, position, attributes)
      puts "section_step #{section_step}"
      @section_step = section_step
      @position = position
      @attributes = attributes
    end

    def self.build(section_step, position, attributes)
      new(section_step, position, attributes).build_lesson
    end

    def build_lesson
      @section_step.children.seed(:learnable_id, :learnable_type, :path_id) do |step|
        step.learnable_id = lesson.id
        step.learnable_type = 'Lesson'
        step.parent = section_step
        step.path_id = section_step.path_id
        step.position = position
      end.first
    end

    # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
    def lesson
      Lesson.seed(:identifier_uuid) do |lesson|
        lesson.identifier_uuid = attributes.fetch(:identifier_uuid)
        lesson.title = attributes.fetch(:title)
        lesson.description = attributes.fetch(:description)
        lesson.github_path = attributes.fetch(:github_path)
        lesson.is_project = attributes.fetch(:is_project, false)
        lesson.accepts_submission = attributes.fetch(:accepts_submission, false)
        lesson.choose_path_lesson = attributes.fetch(:choose_path_lesson, false)
        lesson.installation_lesson = attributes.fetch(:installation_lesson, false)
      end.first
    end
    # rubocop: enable Metrics/AbcSize, Metrics/MethodLength

    private

    attr_reader :section_step, :position, :attributes
  end
end
