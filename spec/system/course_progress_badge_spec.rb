require 'rails_helper'

RSpec.describe 'Course Progress Badge' do
  let!(:path) { create(:path, default_path: true) }
  let!(:course) { create(:course, path:) }
  let!(:first_lesson) { create(:lesson, course:) }
  let!(:second_lesson) { create(:lesson, course:) }

  context 'when signed in' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    context 'when course has not been started' do
      it 'displays 0% completion' do
        visit path_course_path(path, course)

        within :test_id, 'progress-circle' do
          expect(page).to have_content('0%')
        end
      end
    end

    context 'when course has some progress' do
      it 'shows percentage of completion' do
        create(:lesson_completion, user:, lesson: first_lesson, course:)

        visit path_course_path(path, course)

        within :test_id, 'progress-circle' do
          expect(page).to have_content('50%')
        end
      end
    end

    context 'when course is completed' do
      it 'shows 100% completion' do
        create(:lesson_completion, user:, lesson: first_lesson, course:)
        create(:lesson_completion, user:, lesson: second_lesson, course:)

        visit path_course_path(path, course)

        within :test_id, 'progress-circle' do
          expect(page).to have_content('100%')
        end
      end
    end
  end

  context 'when not signed in' do
    it 'displays the course badge' do
      visit path_course_path(path, course)

      within :test_id, 'default-badge' do
        expect(page).to have_no_content('0%')
      end
    end
  end
end
