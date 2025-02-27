class InterviewSurvey < ApplicationRecord
  belongs_to :user
  has_many :interview_survey_concepts, dependent: :destroy

  validates :interview_date, presence: true
  validate :interview_date_cannot_be_in_the_future

  def interview_date_cannot_be_in_the_future
    if interview_date.present? && interview_date > Time.zone.today
      errors.add(:interview_date, "Interview date can't be in the future")
    end
  end
end
