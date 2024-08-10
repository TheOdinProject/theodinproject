require 'rails_helper'

RSpec.describe 'Course Lesson Completions' do
  let!(:user) { create(:user) }
  let!(:path) { create(:path, default_path: true) }
  let!(:course) { create(:course, path:) }
  let!(:section) { create(:section, course:) }

  context 'when user is signed in' do
    before do
      create(:lesson, section:)

      sign_in(user)
      visit path_course_path(path, course)
    end

    it 'completes a lesson' do
      find(:test_id, 'complete-button').click

      expect(page).to have_css('[data-complete="true"]')
    end

    it 'changes a completed lesson to incomplete' do
      find(:test_id, 'complete-button').click

      expect(page).to have_css('[data-complete="true"]')

      find(:test_id, 'complete-button').click
      expect(page).to have_css('[data-complete="false"]')
    end
  end

  context 'when user is not signed in' do
    it 'cannot complete a lesson' do
      visit path_course_path(path, course)

      expect(page).to have_no_css('[data-test_id="complete-button"]')
    end
  end
end
