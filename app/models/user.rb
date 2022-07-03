# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#  learning_goal          :text
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  admin                  :boolean          default(FALSE), not null
#  avatar                 :string
#  path_id                :integer          default(1)
#  banned                 :boolean          default(FALSE), not null
#
class User < ApplicationRecord
  acts_as_voter
  before_create :enroll_in_foundations

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[github google]

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { in: 2..100 }
  validates :learning_goal, length: { maximum: 1700 }

  has_many :lesson_completions, dependent: :destroy
  has_many :completed_lessons, through: :lesson_completions, source: :lesson
  has_many :project_submissions, dependent: :destroy
  has_many :user_providers, dependent: :destroy
  has_many :flags, foreign_key: :flagger_id, dependent: :destroy, inverse_of: :flagger
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :announcements, dependent: nil
  belongs_to :path, optional: true

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
    flags.where(taken_action: :dismiss)
  end

  def started_course?(course)
    lesson_completions.exists?(course_id: course.id)
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
