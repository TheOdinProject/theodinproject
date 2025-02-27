class InterviewConcept < ApplicationRecord
  has_many :interview_survey_concepts, dependent: :destroy

  validates :interview_concepts, presence: true
  validates :interview_concepts, length: { mininum: 1, maximum: 25 }
end
