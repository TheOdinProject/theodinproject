# == Schema Information
#
# Table name: lesson_completions
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  user_id                :integer
#  created_at             :datetime
#  updated_at             :datetime
#  lesson_identifier_uuid :string           default(""), not null
#  course_id              :integer
#  path_id                :integer
#
class LessonCompletion < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  belongs_to :course, optional: true

  validates :user_id, uniqueness: { scope: :lesson_id }

  scope :created_today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }
end
