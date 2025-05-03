class InterviewConcept < ApplicationRecord
  has_many :interview_survey_concepts, dependent: :destroy, inverse_of: :interview_concept

  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 25 }
end
