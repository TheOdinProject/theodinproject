require 'rails_helper'

RSpec.describe InterviewConcept do
  subject(:interview_concept) { create(:interview_concept) }

  it { (is_expected.to have_many(:interview_survey_concepts)) }
  it { is_expected.to validate_presence_of(:interview_concept) }
  it { is_expected.to validate_length_of(:interview_concept).is_at_least(1).is_at_most(25) }
end
