class InterviewConcept < ApplicationRecord
  has_many :interview_survey_concepts, dependent: :destroy, inverse_of: :interview_concept
  has_many :interview_surveys, through: :interview_survey_concepts, inverse_of: :interview_concepts

  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 25 }
end
