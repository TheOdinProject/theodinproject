require 'rails_helper'

RSpec.describe InterviewSurvey do
  subject(:interview_survey) { create(:interview_survey) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:interview_survey_concepts) }

  it { is_expected.to validate_presence_of(:interview_date) }

  describe 'interview_date_cannot_be_in_the_future' do
    it "marks dates as invalid if they're in the future" do
      interview_date_future = create(:interview_survey, created_at: Time.zone.today + 1.day)
      expect(interview_date_future).not_to be_valid

      interview_date_future = create(:interview_survey, created_at: Time.zone.today)
      expect(interview_date_future).to_be_valid
    end
  end
end