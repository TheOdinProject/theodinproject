class Section < ApplicationRecord
  include Stepable

  has_many :lessons, through: :children, source: :learnable, source_type: 'Lesson'
  has_many :courses, through: :parents, source: :learnable, source_type: 'Course'
end
