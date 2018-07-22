class Course < ApplicationRecord
  extend FriendlyId

  has_many :sections, -> { order(:position) }
  has_many :lessons, through: :sections

  validates :position, presence: true

  friendly_id :title, use: [:slugged, :finders]

  def progress_for(user)
    user.progress_for(self)
  end

  private

  def should_generate_new_friendly_id?
      slug.blank? || title_changed?
  end
end
