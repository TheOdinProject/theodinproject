class Lesson < ApplicationRecord
  extend FriendlyId

  friendly_id :slug_candidates, use: %i[slugged history finders]

  belongs_to :section
  has_one :course, through: :section
  has_one :path, through: :course
  has_many :project_submissions, dependent: :destroy
  has_many :lesson_completions, dependent: :destroy
  has_many :completing_users, through: :lesson_completions, source: :user

  scope :most_recent_updated_at, -> { maximum(:updated_at) }

  validates :position, presence: true

  def position_in_section
    section_lessons.where('position <= ?', position).count
  end

  def import_content_from_github
    LessonContentImporter.for(self)
  end

  private

  def section_lessons
    section.lessons
  end

  def slug_candidates
    [
      :title,
      [section&.title, :title],
      [section&.title, course&.title, :title],
      [section&.title, course&.title, path&.title, :title]
    ]
  end
end
