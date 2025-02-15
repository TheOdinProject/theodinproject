require 'rails_helper'

RSpec.describe InterviewConcept, type: :model do
  subject(:interview_concept) {create(:interview_concept)}

  it {(is_expected.to have_many(:interview_survey_concepts))}

end
