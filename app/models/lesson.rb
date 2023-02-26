class Lesson < ApplicationRecord
  include Stepable
  extend FriendlyId

  friendly_id :slug_candidates, use: %i[slugged history finders]

  has_many :paths, through: :steps, source: :path
  has_many :sections, through: :parents, source: :learnable, source_type: 'Section'
  has_many :courses, through: :sections

  has_one :content, dependent: :destroy
  has_many :project_submissions, dependent: :destroy
  has_many :lesson_completions, dependent: :destroy
  has_many :completing_users, through: :lesson_completions, source: :user

  scope :most_recent_updated_at, -> { maximum(:updated_at) }
  scope :installation_lessons, -> { where(installation_lesson: true) }

  validates :position, presence: true

  delegate :body, to: :content

  def import_content_from_github
    LessonContentImporter.for(self)
  end

  private

  # def slug_candidates
  #   [
  #     [course.title, title].uniq,
  #     [course.path_short_title, course.title, title].uniq,
  #     [course.path_short_title, course.title, title, SecureRandom.hex(2)].uniq
  #   ]
  # end

  def slug_candidates
    [
      [title].uniq,
      [title, SecureRandom.hex(2)].uniq
    ]
  end
end
