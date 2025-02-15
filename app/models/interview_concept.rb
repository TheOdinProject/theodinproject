class InterviewConcept < ApplicationRecord
  has_many :interview_survey_concepts, dependent: :destroy
end
