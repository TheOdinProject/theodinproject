module Seeds
  class LessonBuilder
    def initialize(parent, position, lesson)
      @parent = parent
      @position = position
      @lesson = lesson
    end

    def self.build(parent, position, lesson)
      new(parent, position, lesson).build_lesson_step
    end

    def build_lesson_step
      @parent.children.seed(:learnable_id, :learnable_type, :path_id) do |step|
        step.learnable_id = lesson.id
        step.learnable_type = 'Lesson'
        step.parent = parent
        step.path_id = parent.path_id
        step.position = position
      end.first
    end

    private

    attr_reader :parent, :position, :lesson
  end
end
