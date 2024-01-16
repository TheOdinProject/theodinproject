class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :lesson, uniqueness: { scope: :user, message: 'user has already bookmarked this lesson' }

  delegate :title, to: :lesson
end
