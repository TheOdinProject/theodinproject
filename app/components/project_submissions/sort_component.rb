module ProjectSubmissions
  class SortComponent < ApplicationComponent

    def initialize(lesson:, options:)
      @lesson = lesson
      @options = options
    end

    private

    attr_reader :lesson, :options

  end
end


