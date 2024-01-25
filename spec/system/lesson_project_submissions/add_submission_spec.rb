require 'rails_helper'

RSpec.describe 'Add a Project Submission' do
  context 'when a user is signed in' do
    let(:lesson) { create(:lesson, :project) }
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    before do
      sign_in(user)
      visit lesson_path(lesson)
    end

    it 'successfully adds a submission' do
      within(:test_id, 'current-user-solution') do
        expect(page).to have_content('Submit your solution')
        expect(page).not_to have_content(lesson.title)
      end

      Pages::ProjectSubmissions::Form.new.open.fill_in.submit

      within(:test_id, 'current-user-solution') do
        expect(page).to have_content(lesson.title)
        expect(page).not_to have_content('Submit your solution')
      end
    end

    context 'when setting a submission as private' do
      it 'will display the submission for its owner but not for other users' do
        form = Pages::ProjectSubmissions::Form.new.open.fill_in
        form.make_private
        form.submit

        within(:test_id, 'current-user-solution') do
          expect(page).to have_content(lesson.title)
          expect(page).not_to have_content('Submit your solution')
        end

        click_link('View community solutions')

        within(:test_id, 'submissions-list') do
          page.driver.refresh
          expect(page).not_to have_content(user.username)
        end

        using_session('another_user') do
          sign_in(another_user)
          visit lesson_project_submissions_path(lesson)

          within(:test_id, 'submissions-list') do
            expect(page).not_to have_content(user.username)
          end
        end
      end
    end
  end

  context 'when lesson does not allow previews' do
    let(:lesson) { create(:lesson, :project, previewable: false) }
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit lesson_path(lesson)
    end

    it 'adds the submission without a preview' do
      Pages::ProjectSubmissions::Form
        .new(previewable: false)
        .open
        .fill_in
        .submit

      within(:test_id, 'current-user-solution') do
        expect(page).to have_content(lesson.title)
        expect(page).to have_link('View code')
        expect(page).not_to have_link('Live preview')
      end
    end
  end

  context 'when a user is not signed in' do
    it 'they cannot add a project submission' do
      lesson = create(:lesson, :project)
      visit lesson_path(lesson)

      expect(page).not_to have_content('Submit your solution')
    end
  end
end
