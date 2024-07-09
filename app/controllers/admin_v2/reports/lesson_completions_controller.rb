module AdminV2
  class Reports::LessonCompletionsController < AdminV2::BaseController
    before_action :set_date_range, only: :show

    def show
      @lesson_completions_stats = ::Reports::AllLessonCompletionsDayStat
        .for_date_range(@start, @end)
        .group_by_period(params.fetch(:period, 'day'))
    end

    private

    def set_date_range
      @earliest = ::Reports::AllLessonCompletionsDayStat.earliest_date
      @latest = default_end_date

      @start = Date.parse(params.fetch(:start, default_start_date))
      @end = Date.parse(params.fetch(:end, default_end_date))
    end

    def default_start_date
      return 3.months.ago.to_date.to_s if params[:period] == 'month'

      7.days.ago.to_date.to_s
    end

    def default_end_date
      Time.zone.today.to_s
    end
  end
end
