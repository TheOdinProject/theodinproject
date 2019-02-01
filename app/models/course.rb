class Course < ApplicationRecord
  extend FriendlyId

  has_many :sections, -> { order(:position) }
  has_many :lessons, through: :sections
  has_and_belongs_to_many :tracks

  validates :position, presence: true

  friendly_id :title, use: [:slugged, :finders]

  def progress_for(user)
    user.progress_for(self)
  end
end
