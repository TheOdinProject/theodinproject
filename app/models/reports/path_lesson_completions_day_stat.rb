class Reports::PathLessonCompletionsDayStat < ApplicationRecord
  include MaterializedView

  belongs_to :path
  belongs_to :course

  scope :for_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }

  scope :group_by_lesson, lambda {
    group(:lesson_title, :lesson_id, :lesson_position, :course_position)
      .order(course_position: :asc, lesson_position: :asc)
      .sum(:completions_count)
      .map { |(lesson_title), count| Stat.new(lesson_title, count) }
  }

  def self.filter_by_course(course_id)
    return all if course_id.blank?

    where(course_id:)
  end

  def self.earliest_date
    minimum(:date) || Time.zone.today
  end

  def self.latest_date
    maximum(:date) || Time.zone.today
  end

  class Stat
    attr_reader :lesson_title, :count

    def initialize(lesson_title, count)
      @lesson_title = lesson_title
      @count = count
    end
  end
end
