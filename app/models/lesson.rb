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
    Github::LessonContentImporter.for(self)
  end

  def display_title
    return "Project: #{title}" if is_project?

    title
  end

 def locked_for?(user)
    return false if user.nil? && position <= first_project_position  # Unauthenticated users can view up to first project
    return false if user.nil?                                        # Everything else locked for guests

    project_lessons = Lesson.where(course_id: course.id, is_project: true).order(:position)
    return false if project_lessons.empty?

    # Get all approved project positions for this user
    approved_positions = Lesson
      .joins(:project_submissions)
      .where(course_id: course.id, is_project: true, project_submissions: { user_id: user.id, isapprove: true })
      .order(:position)
      .pluck(:position)

    # Determine how far the user can go
    if approved_positions.empty?
      # No projects approved, user can view up to the first project
      return position > first_project_position
    else
      # Find the next project after the highest approved one
      max_approved = approved_positions.max
      next_project = project_lessons.find { |l| l.position > max_approved }
      unlock_until = next_project ? next_project.position : Lesson.where(course_id: course.id).maximum(:position)
      return position > unlock_until
    end
end

private

def first_project_position
  Lesson.where(course_id: course.id, is_project: true).order(:position).pluck(:position).first || 1
end


  # def locked_for?(user)
  #    return position > 1 if user.nil?
  #   # Get the last approved lesson for this user
  #   last_approved_lesson = Lesson
  #     .joins(:project_submissions)
  #     .where('project_submissions.user_id = ? AND project_submissions.isapprove = ?', user.id, true)
  #     .order(:position)
  #     .last

  #   return position > 1 if last_approved_lesson.nil?
  #   position > (last_approved_lesson.position + 1)
  # end

  private

  def slug_candidates
    [
      [course.title, title].uniq,
      [course.path_short_title, course.title, title].uniq,
      [course.path_short_title, course.title, title, SecureRandom.hex(2)].uniq
    ]
  end
end
