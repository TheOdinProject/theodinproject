class Reports::UserSignUpsDayStat < ApplicationRecord
  include MaterializedView

  scope :for_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }

  scope :group_by_period, lambda { |period|
    group("DATE_TRUNC('#{period}', date)")
      .order(Arel.sql("DATE_TRUNC('#{period}', date) ASC"))
      .sum(:sign_ups_count)
  }

  def self.earliest_date
    minimum(:date) || Time.zone.today
  end

  def self.latest_date
    maximum(:date) || Time.zone.today
  end
end
