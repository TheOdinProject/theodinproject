require 'rails_helper'

RSpec.describe 'Course Progress Badge' do
  let!(:path) { create(:path, default_path: true) }
  let!(:course) { create(:course, path:) }
  let!(:first_lesson) { create(:lesson, course:) }
  let!(:second_lesson) { create(:lesson, course:) }

  context 'when signed in' do
    before do
      sign_in(create(:user))
    end

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
        visit lesson_path(first_lesson)

        find(:test_id, 'complete-button').click
        visit path_course_path(path, course)

        within :test_id, 'progress-circle' do
          expect(page).to have_content('50%')
        end
      end
    end

    context 'when course is completed' do
      it 'shows 100% completion' do
        visit lesson_path(first_lesson)
        find(:test_id, 'complete-button').click

        visit lesson_path(second_lesson)
        find(:test_id, 'complete-button').click

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
