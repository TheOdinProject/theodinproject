class InterviewSurvey < ApplicationRecord
  belongs_to :user
  has_many :interview_survey_concepts, dependent: :destroy, inverse_of: :interview_survey
  has_many :interview_concepts,
           through: :interview_survey_concepts,
           inverse_of: :interview_surveys

  accepts_nested_attributes_for :interview_concepts

  validates :interview_date, presence: true
  validate :interview_date_must_be_in_the_past

  def concept_list=(concept_names)
    self.interview_concepts = concept_names.compact_blank.map do |name|
      InterviewConcept.find_or_create_by(name:)
    end
  end

  def interview_date_must_be_in_the_past
    return if interview_date.present? && interview_date <= Time.zone.today

    errors.add(:interview_date, "Interview date can't be in the future")
  end
end
