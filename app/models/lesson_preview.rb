class LessonPreview < ApplicationRecord
  validates :content, presence: true, length: { maximum: 70_000 }

  scope :expired, -> { where(created_at: ..1.month.ago.end_of_day) }
end
