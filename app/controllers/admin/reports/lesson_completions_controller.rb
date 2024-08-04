module Admin
  class Reports::LessonCompletionsController < Admin::BaseController
    before_action :set_date_range, only: :show

    def show
      @lesson_completions_stats = ::Reports::AllLessonCompletionsDayStat
        .for_date_range(@start, @end)
        .group_by_period(period.name)
    end

    private

    def set_date_range
      @earliest = ::Reports::AllLessonCompletionsDayStat.earliest_date
      @latest = default_end_date

      @start = Date.parse(params.fetch(:start, default_start_date))
      @end = Date.parse(params.fetch(:end, default_end_date))
    end

    def default_start_date
      {
        'day' => 7.days.ago,
        'month' => 3.months.ago,
        'year' => 3.years.ago
      }.fetch(period.name).to_date.to_s
    end

    def default_end_date
      Time.zone.today.to_s
    end

    def period
      @period ||= ::Reports::Period.find(params[:period]) || ::Reports::Period.new('day')
    end
  end
end
