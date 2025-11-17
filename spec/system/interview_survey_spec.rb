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

    it 'creates an interview survey with existing concepts' do
      visit new_interview_survey_path
      expect(page).to have_content('Interview Survey')

      fill_in :interview_survey_interview_date, with: Date.current

      find('div[class="ts-control"]').click
      find('div[role="option"]', text: 'Rails routing').click

      click_on 'Submit'

      expect(page).to have_content('Survey submitted')
    end

    it 'creates an interview survey with new concepts' do
      visit new_interview_survey_path

      fill_in :interview_survey_interview_date, with: Date.current

      find('div[class="ts-control"]').click
      find('input[id="interview_survey_interview_concept_names-ts-control"]')
        .set('React props')
        .send_keys(:return)

      click_on 'Submit'

      expect(page).to have_content('Survey submitted')
    end

    it 'reports validation errors with invalid form data' do
      visit new_interview_survey_path

      fill_in :interview_survey_interview_date, with: Date.current + 3.days

      find('div[class="ts-control"]').click
      find('div[role="option"]', text: 'Rails routing').click

      click_on 'Submit'

      expect(page).to have_content("Interview date can't be in the future")
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
