require 'rails_helper'

RSpec.describe 'Navigating Lessons' do
  let!(:course) { create(:course, path: create(:path, default_path: true)) }
  let!(:section) { create(:section, position: 1, course:) }
  let!(:lesson) { create(:lesson, position: 1, section:) }

  before do
    sign_in(create(:user))
  end

  describe 'the next lesson button' do
    context 'when the next lesson is within the same section' do
      let!(:next_lesson) { create(:lesson, position: 2, section:) }

      it 'moves to the next lesson in the section when clicked' do
        visit lesson_path(lesson)
        find(:test_id, 'next-lesson-btn').click

        expect(find(:test_id, 'lesson-title-header')).to have_text(/#{next_lesson.title}/i)
      end
    end

    context 'when on the last lesson of a section' do
      let!(:next_section) { create(:section, position: 2, course:) }
      let!(:next_section_lesson) { create(:lesson, position: 2, section: next_section) }

      it 'moves to the first lesson in the next section when clicked' do
        visit lesson_path(lesson)
        find(:test_id, 'next-lesson-btn').click

        expect(find(:test_id, 'lesson-title-header')).to have_text(/#{next_section_lesson.title}/i)
      end
    end

    context 'when on last lesson in the course' do
      it 'is not present' do
        visit lesson_path(lesson)

        expect(page).not_to have_css('[data-test-id="next-lesson-btn"]')
      end
    end
  end

  describe 'the View Course button' do
    it 'directs to the course view' do
      visit lesson_path(lesson)
      find(:test_id, 'view-course-btn').click

      expect(find(:test_id, 'course-title-header')).to have_text(/#{course.title}/i)

      within '[data-test-id="course-section"]', match: :first do
        expect(page).to have_text(/#{lesson.title}/i)
      end
    end
  end

  describe 'Choose Path Lesson button' do
    it 'directs the user to the path selection page' do
      choose_path_lesson = create(:lesson, position: 2, section:, choose_path_lesson: true)

      visit lesson_path(choose_path_lesson)
      find(:test_id, 'choose-path-lesson-btn').click

      expect(page).to have_current_path(paths_path)
    end
  end
end
