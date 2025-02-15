require 'rails_helper'

RSpec.describe InterviewSurvey do
  subject(:interview_survey) { create(:interview_survey) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:interview_survey_concepts) }
end
