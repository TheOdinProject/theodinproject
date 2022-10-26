class LessonPreview < ApplicationRecord
  validates :content, presence: true
end
