class InterviewSurvey < ApplicationRecord
  belongs_to :user
  has_many :interview_survey_concepts, dependent: :destroy
  has_many :interview_concepts, through: :interview_survey_concepts

  accepts_nested_attributes_for :interview_concepts

  validates :interview_date, presence: true
  validate :interview_date_must_be_in_the_past

  def interview_date_must_be_in_the_past
    return if interview_date.present? && interview_date <= Time.zone.today

    errors.add(:interview_date, "Interview date can't be in the future")
  end
end
