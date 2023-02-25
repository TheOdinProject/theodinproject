class Path < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: %i[slugged history finders]

  has_many :users, dependent: :nullify
  has_many :steps, -> { ordered }, dependent: :destroy, inverse_of: :path
  has_many :courses, through: :steps, source: :learnable, source_type: 'Course'
  has_many :path_prerequisites, dependent: :destroy
  has_many :prerequisites, through: :path_prerequisites, source: :prerequisite

  validates :title, presence: true
  validates :description, presence: true
  validates :position, presence: true

  scope :fullstack_paths, -> { where.not(default_path: true) }

  def self.default_path
    find_by(default_path: true)
  end
end
