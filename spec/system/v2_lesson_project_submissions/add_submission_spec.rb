require 'rails_helper'

RSpec.describe 'Add a Project Submission' do
  before do
    Flipper.enable(:v2_project_submissions)
  end

  after do
    Flipper.disable(:v2_project_submissions)
  end

  context 'when a user is signed in' do
    let(:lesson) { create(:lesson, :project) }
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    before do
      sign_in(user)
      visit lesson_path(lesson)
    end

    it 'successfully adds a submission' do
      form = Pages::ProjectSubmissions::Form.new.open.fill_in.submit

      within(:test_id, 'submissions-list') do
        expect(page).to have_content(user.username)
      end

      expect(page).not_to have_button('Add Solution')
    end

    context 'when setting a submission as private' do
      it 'will display the submission for the submission owner but not for other users' do
        form = Pages::ProjectSubmissions::Form.new.open.fill_in
        form.v2_make_private
        form.submit

        within(:test_id, 'submissions-list') do
          page.driver.refresh
          expect(page).to have_content(user.username)
        end

        expect(page).not_to have_content('Add solution')

        using_session('another_user') do
          sign_in(another_user)
          visit lesson_path(lesson)

          within(:test_id, 'submissions-list') do
            expect(page).not_to have_content(user.username)
          end
        end
      end
    end
  end

  context 'when lesson does not allow previews' do
    let(:lesson) { create(:lesson, :project, has_live_preview: false) }
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit lesson_path(lesson)
    end

    it 'adds the submission without a preview' do
      Pages::ProjectSubmissions::Form
        .new(has_live_preview: false)
        .open
        .fill_in
        .submit

      within(:test_id, 'submissions-list') do
        expect(page).to have_content(user.username)
        expect(page).to have_link('View code')
        expect(page).not_to have_link('Live preview')
      end
    end
  end

  context 'when a user is not signed in' do
    it 'they cannot add a project submission' do
      lesson = create(:lesson, :project)
      visit lesson_path(lesson)

      expect(page).not_to have_button('Add Solution')
    end
  end
end
