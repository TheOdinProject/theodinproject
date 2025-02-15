require 'rails_helper'

RSpec.describe InterviewSurveyConcept, type: :model do
  subject(:interview_survey_concept) { create(:interview_survey_concept)}

  it {(is_expected.to belong_to(:interview_survey))}
  it {(is_expected.to belong_to(:interview_concept))}

end
