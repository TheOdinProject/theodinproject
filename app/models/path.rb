# == Schema Information
#
# Table name: paths
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :string
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  slug            :string
#  default_path    :boolean          default(FALSE), not null
#  identifier_uuid :string           default(""), not null
#  short_title     :string
#
class Path < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: %i[slugged history finders]

  has_many :users, dependent: :nullify
  has_many :courses, -> { order(:position) }, dependent: :destroy, inverse_of: :path
  has_many :path_prerequisites, dependent: :destroy
  has_many :prerequisites, through: :path_prerequisites, source: :prerequisite

  validates :title, presence: true
  validates :description, presence: true
  validates :position, presence: true

  def self.default_path
    find_by(default_path: true)
  end
end
