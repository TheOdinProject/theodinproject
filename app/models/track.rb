class Track < ApplicationRecord
  has_and_belongs_to_many :courses

  validates :title, presence: true
  validates :description, presence: true
  validates :position, presence: true
end
