require 'rails_helper'

RSpec.describe 'Resuming Course from User Dashboard' do
  let!(:default_path) { create(:path, default_path: true) }
  let!(:foundations_course) { create(:course, title: 'Foundations', path: default_path) }
  let!(:incomplete_lesson) { create(:lesson, course: foundations_course) }

  context 'when user has completed first lesson in course' do
    let(:user) { create(:user) }

    before do
      completed_lesson = create(:lesson, course: foundations_course)
      create(:lesson_completion, user:, lesson: completed_lesson, course: foundations_course)

      sign_in(user)
      visit dashboard_path
    end

    it 'has button to resume course' do
      expect(find(:test_id, 'foundations-resume-btn')).to have_text('Resume')
    end

    it 'successfully resumes next incomplete lesson' do
      find(:test_id, 'foundations-resume-btn').click

      expect(page).to have_current_path(lesson_path(incomplete_lesson))
    end
  end
end
