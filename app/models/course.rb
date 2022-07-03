# == Schema Information
#
# Table name: courses
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position         :integer          not null
#  slug             :string
#  identifier_uuid  :string           default(""), not null
#  path_id          :integer
#  show_on_homepage :boolean          default(FALSE), not null
#  badge_uri        :string           not null
#
class Course < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: %i[scoped slugged history finders], scope: :path

  belongs_to :path
  has_many :sections, -> { order(:position) }, dependent: :destroy, inverse_of: :course
  has_many :lessons, through: :sections

  validates :position, presence: true

  delegate :short_title, to: :path, prefix: true

  scope :badges, -> { Course.where(show_on_homepage: true) }

  def progress_for(user)
    user.progress_for(self)
  end
end
