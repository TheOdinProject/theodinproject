require 'rails_helper'

RSpec.describe InterviewSurvey do
  subject(:interview_survey) { create(:interview_survey) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:interview_survey_concepts) }

  it { is_expected.to validate_presence_of(:interview_date) }

  it { is_expected.to allow_value(Time.zone.today).for(:interview_date) }
  it { is_expected.to allow_value(1.day.ago).for(:interview_date) }
  it { is_expected.not_to allow_value(1.day.from_now).for(:interview_date) }
end
