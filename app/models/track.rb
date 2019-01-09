class Track < ApplicationRecord
  has_many :track_units
  has_many :lessons, through: :track_units
end
