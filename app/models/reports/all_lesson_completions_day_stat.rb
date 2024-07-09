class Reports::AllLessonCompletionsDayStat < ApplicationRecord
  scope :for_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }

  scope :group_by_period, lambda { |period|
    group("DATE_TRUNC('#{period}', date)")
      .order(Arel.sql("DATE_TRUNC('#{period}', date) ASC"))
      .sum(:completions_count)
  }

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  def self.earliest_date
    minimum(:date) || Time.zone.today
  end

  def self.latest_date
    maximum(:date) || Time.zone.today
  end

  def readonly?
    true
  end
end
