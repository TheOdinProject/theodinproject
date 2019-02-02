class Track < ApplicationRecord
  has_many :users
  has_many :track_courses, dependent: :destroy
  has_many :courses, through: :track_courses

  validates :title, presence: true
  validates :description, presence: true
  validates :position, presence: true
end
