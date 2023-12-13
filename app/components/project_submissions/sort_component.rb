module ProjectSubmissions
  class SortComponent < ApplicationComponent

    def initialize(lesson:, options:, selected:)
      @lesson = lesson
      @options = options
      @selected = selected
    end

    private

    attr_reader :lesson, :options, :selected


  end
end


