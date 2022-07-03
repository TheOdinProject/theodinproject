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
class LessonSerializer
  def initialize(lesson, between_dates = nil)
    @lesson = lesson
    @between_dates = between_dates
  end

  def self.as_json(lesson, between_dates = nil)
    new(lesson, between_dates).as_json
  end

  def as_json(_options = nil)
    {
      title: lesson.title,
      completions: completions.count,
    }
  end

  private

  attr_reader :lesson, :between_dates

  def completions
    lesson.lesson_completions.where(created_at: between_dates)
  end
end
