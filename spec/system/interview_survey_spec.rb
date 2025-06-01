require 'rails_helper'

RSpec.describe 'Interview survey' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  context 'when the feature is enabled' do
    before do
      Flipper.enable(:survey_feature)
      create(:interview_concept, name: 'Rails routing')
    end

    it 'shows the survey' do
      visit new_interview_survey_path
      expect(page).to have_content('Interview Survey')
    end

    it 'creates an interview survey with existing concepts' do
      visit new_interview_survey_path

      fill_in :interview_survey_interview_date, with: Date.current

      find('div[aria-label="Combobox"]').click
      find('div[class="ss-option"]', text: 'Rails routing').click

      click_on 'Submit'

      expect(page).to have_content('Survey Submitted')
    end
  end

  context 'when the feature is disabled' do
    it 'redirects to the dashboard' do
      visit new_interview_survey_path
      expect(page).to have_content('Feature not enabled')
      expect(page).to have_current_path(dashboard_path)
    end
  end
end
