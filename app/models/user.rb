class User < ApplicationRecord
  include PgSearch::Model

  before_create :enroll_in_foundations

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[github google]

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { in: 2..100 }
  validates :mobile_number,
          presence: true,
          format: { with: /\A[6-9]\d{9}\z/, message: 'must be a valid 10-digit mobile number' }

  validates :username, :email, :password, :password_confirmation,
            :mobile_number, :college, :degree, :graduation_year,
            :city, :state, :country, :operating_system, :resume,
            presence: true

  validates :learning_goal, length: { maximum: 1700 }
  validates :graduation_year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1950,
    less_than_or_equal_to: 2050,
    message: "must be between 1950 and 2050"
  }


  has_many :lesson_completions, dependent: :destroy
  has_many :completed_lessons, through: :lesson_completions, source: :lesson
  has_many :project_submissions, dependent: :destroy
  has_many :user_providers, dependent: :destroy
  has_many :flags, foreign_key: :flagger_id, dependent: :destroy, inverse_of: :flagger
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :announcements, dependent: nil
  has_many :likes, dependent: :destroy
  has_one_attached :resume


  belongs_to :path, optional: true, counter_cache: true

  scope :created_after, ->(date) { where(arel_table[:created_at].gt(date)) }
  scope :signed_up_on, ->(date) { where(created_at: date.all_day) }
  scope :banned, -> { where(banned: true) }

  pg_search_scope(
    :search_by,
    against: %i[
      username
      email
    ],
    using: {
      tsearch: {
        prefix: true,
        dictionary: 'english',
        tsvector_column: 'search_tsvector'
      }
    }
  )

  def progress_for(course)
    @progress ||= Hash.new { |hash, c| hash[c] = CourseProgress.new(c, self) }
    @progress[course]
  end

  def completed?(lesson)
    completed_lessons.pluck(:id).include?(lesson.id)
  end

  def latest_completed_lesson
    return if last_lesson_completed.nil?

    Lesson.find(last_lesson_completed.lesson_id)
  end

  def lesson_completions_for_course(course)
    lesson_completions.where(course_id: course.id)
  end

  def active_for_authentication?
    super && !banned?
  end

  def inactive_message
    banned? ? :banned : super
  end

  def dismissed_flags
    flags.where(action_taken: :dismiss)
  end

  def started_course?(course)
    lesson_completions.exists?(course_id: course.id)
  end

  def on_path?(path)
    self.path == path
  end

  def ban!
    ActiveRecord::Base.transaction do
      project_submissions.each(&:discard)
      update!(banned: true)
    end
  end

  private

  def last_lesson_completed
    lesson_completions.order(created_at: :asc).last
  end

  def enroll_in_foundations
    default_path = Path.default_path

    self.path_id = default_path.id if default_path.present?
  end
end
