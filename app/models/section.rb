class Section < ApplicationRecord
  belongs_to :course

  has_many :steps, -> { ordered }, dependent: :destroy
  has_many :lessons, through: :steps, source: :learnable, source_type: 'Lesson'


  # has_many :lessons, -> { order(:position) }, inverse_of: :section, dependent: :destroy

  validates :position, presence: true
end
