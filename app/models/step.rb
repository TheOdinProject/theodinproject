class Step < ApplicationRecord
  has_closure_tree dependent: :destroy

  LEARNABLE_TYPES = %w[Lesson Section Course].freeze

  delegated_type :learnable, types: LEARNABLE_TYPES

  belongs_to :path

  def parent_course
    ancestors.where(learnable_type: 'Course').first.learnable
  end

  # belongs_to :parent, class_name: 'Step', optional: true, inverse_of: :children
  # has_one :parent_course, through: :parent, source: :learnable, source_type: 'Course'

  # has_many :children, class_name: 'Step', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  # has_many :lessons, through: :children, source: :learnable, source_type: "Lesson"

  scope :ordered, -> { order(position: :asc) }

  def previous
    parent.children.where('position < ?', position).last
  end
  alias previous? previous

  def next
    @next ||= parent.children.where('position > ?', position).first
  end
  alias next? next

  def next_lesson_for(_course, completed_lessons)
    completed_course_lessons = completed_lessons.where(id: leaves.ids)
    completed_steps
    remainingleaves.select { |step| completed_course_lessons.ids.include?(step.learnable.id) }
  end
end
