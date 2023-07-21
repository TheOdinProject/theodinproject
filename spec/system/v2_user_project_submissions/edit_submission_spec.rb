require 'rails_helper'

RSpec.describe 'Editing a Project Submission on the Dashboard' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }
  let(:edited_field_values) do
    {
      repo_url: 'https://github.com/edited-project-repo-url',
      live_preview_url: 'http://edited-live-preview-url.com'
    }
  end

  before do
    Flipper.enable(:v2_project_submissions)

    create(:project_submission, user:, lesson:)
    sign_in(user)
    visit dashboard_path
  end

  after do
    Flipper.disable(:v2_project_submissions)
  end

  it 'successfully edits a submission' do
    sleep 0.1 # it will not open the dropdown without this
    find(:test_id, 'submission-action-menu-btn').click
    find(:test_id, 'edit-submission').click

    Pages::ProjectSubmissions::Form.new(**edited_field_values).tap do |edit_form|
      edit_form.fill_in
      edit_form.submit
    end

    within(:test_id, 'submission-item') do
      expect(page).to have_content(lesson.title)
      expect(page.find(:test_id, 'view-code-btn')['href']).to eq('https://github.com/edited-project-repo-url')
      expect(page.find(:test_id, 'live-preview-btn')['href']).to eq('http://edited-live-preview-url.com/')
    end

    # mark the submission as private

    find(:test_id, 'submission-action-menu-btn').click
    find(:test_id, 'edit-submission').click

    Pages::ProjectSubmissions::Form.new.tap do |form|
      form.v2_make_private
      form.submit
    end

    within(:test_id, 'user-submissions-list') do
      expect(page).to have_content(lesson.title)
    end

    using_session('another_user') do
      sign_in(another_user)
      visit lesson_path(lesson)

      within(:test_id, 'submissions-list') do
        expect(page).not_to have_content(user.username)
      end
    end
  end
end
