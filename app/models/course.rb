class Course < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: %i[slugged history finders]

  belongs_to :path
  has_many :sections, -> { order(:position) }, dependent: :destroy
  has_many :lessons, through: :sections

  validates :position, presence: true

  def progress_for(user)
    user.progress_for(self)
  end
end
