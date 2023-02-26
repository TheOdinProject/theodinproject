class LessonCompletion < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  belongs_to :course, optional: true

  validates :user_id, uniqueness: { scope: :lesson_id }

  scope :created_today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }
  scope :most_recent, -> { order(created_at: :desc).limit(1).first }
  scope :for_course_lessons, ->(course) { where(lesson_id: course.lesson_ids) }
end
