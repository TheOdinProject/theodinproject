class LessonPreview < ApplicationRecord
  validates :content, presence: true, length: { maximum: 70_000 }
end
