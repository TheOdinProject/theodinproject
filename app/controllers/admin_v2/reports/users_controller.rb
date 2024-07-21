module AdminV2
  class Reports::UsersController < AdminV2::BaseController
    before_action :set_date_range, only: :index

    def index
      @sign_up_stats = ::Reports::UserSignUpsDayStat
        .for_date_range(@start, @end)
        .group_by_period(params.fetch(:period, 'day'))
    end

    private

    def set_date_range
      @earliest = ::Reports::UserSignUpsDayStat.earliest_date
      @latest = default_end_date

      @start = Date.parse(params.fetch(:start, default_start_date))
      @end = Date.parse(params.fetch(:end, default_end_date))
    end

    def default_start_date
      {
        'day' => 7.days.ago,
        'month' => 3.months.ago,
        'year' => 3.years.ago
      }.fetch(params[:period], 7.days.ago).to_date.to_s
    end

    def default_end_date
      Time.zone.today.to_s
    end
  end
end
