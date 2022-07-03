# == Schema Information
#
# Table name: lessons
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  github_path         :string(255)
#  position            :integer          not null
#  description         :text
#  is_project          :boolean          default(FALSE)
#  section_id          :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content             :text
#  slug                :string
#  accepts_submission  :boolean          default(FALSE), not null
#  has_live_preview    :boolean          default(FALSE), not null
#  choose_path_lesson  :boolean          default(FALSE), not null
#  identifier_uuid     :string           default(""), not null
#  course_id           :bigint
#  installation_lesson :boolean          default(FALSE)
#
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
  scope :installation_lessons, -> { where(installation_lesson: true) }

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
      [course.title, title].uniq,
      [course.path_short_title, course.title, title].uniq,
      [course.path_short_title, course.title, title, SecureRandom.hex(2)].uniq
    ]
  end
end
