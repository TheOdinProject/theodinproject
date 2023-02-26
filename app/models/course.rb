class Course < ApplicationRecord
  include Stepable
  extend FriendlyId

  friendly_id :title, use: %i[slugged history finders]

  has_many :paths, through: :steps, source: :path
  has_many :sections, through: :children, source: :learnable, source_type: 'Section'
  has_many :lessons, through: :sections

  validates :position, presence: true

  scope :badges, -> { Course.where(show_on_homepage: true) }

  def progress_for(user)
    user.progress_for(self)
  end
end
