class InterviewSurvey < ApplicationRecord
  belongs_to :user
  has_many :interview_survey_concepts
end
