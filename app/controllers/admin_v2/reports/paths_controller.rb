module AdminV2
  class Reports::PathsController < AdminV2::BaseController
    before_action :set_date_range, only: :show

    def show
      @path = Path.find(params[:id])

      @path_lesson_completions = @path.lesson_completion_stats
        .filter_by_course(params[:course_id])
        .for_date_range(@start, @end)
        .group_by_lesson
    end

    private

    def set_date_range
      @earliest = ::Reports::PathLessonCompletionsDayStat.earliest_date
      @latest = default_end_date

      @start = Date.parse(params.fetch(:start, default_start_date))
      @end = Date.parse(params.fetch(:end, default_end_date))
    end

    def default_start_date
      1.month.ago.to_date.to_s
    end

    def default_end_date
      Time.zone.today.to_s
    end
  end
end
