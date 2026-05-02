require 'rails_helper'

RSpec.describe 'Opening Course from User Dashboard' do
  let!(:default_path) { create(:path, default_path: true) }
  let!(:foundations_course) { create(:course, title: 'Foundations', path: default_path) }

  context 'when user has completed a course' do
    let(:user) { create(:user) }

    before do
      first_lesson = create(:lesson, course: foundations_course)
      second_lesson = create(:lesson, course: foundations_course)
      create(:lesson_completion, user:, lesson: first_lesson, course: foundations_course)
      create(:lesson_completion, user:, lesson: second_lesson, course: foundations_course)

      sign_in(user)
      visit dashboard_path
    end

    it 'has button to open course' do
      expect(find(:test_id, 'foundations-open-btn')).to have_text('Open')
    end

    it 'successfully opens course' do
      find(:test_id, 'foundations-open-btn').click

      expect(page).to have_current_path(path_course_path(default_path, foundations_course))
    end
  end
end
