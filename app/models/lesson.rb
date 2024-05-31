class Lesson < ApplicationRecord
  extend FriendlyId

  friendly_id :slug_candidates, use: %i[slugged history finders]

  belongs_to :section
  has_one :course, through: :section
  has_one :path, through: :course
  has_one :content, dependent: :destroy
  has_many :project_submissions, dependent: :destroy
  has_many :lesson_completions, dependent: :destroy
  has_many :completing_users, through: :lesson_completions, source: :user

  scope :most_recent_updated_at, -> { maximum(:updated_at) }
  scope :installation_lessons, -> { where(installation_lesson: true) }

  validates :position, presence: true

  delegate :body, to: :content

  attribute :completed, :boolean, default: false

  def recently_added?
    created_at > 2.weeks.ago.beginning_of_day
  end

  def complete!
    self.completed = true
  end

  def incomplete!
    self.completed = false
  end

  def import_content_from_github
    LessonContentImporter.for(self)
  end

  def display_title
    return "Project: #{title}" if is_project?

    title
  end

  private

  def slug_candidates
    [
      [course.title, title].uniq,
      [course.path_short_title, course.title, title].uniq,
      [course.path_short_title, course.title, title, SecureRandom.hex(2)].uniq
    ]
  end
end
