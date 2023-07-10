require 'rails_helper'

RSpec.describe 'Editing a Project Submission' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }
  let(:edited_field_values) do
    {
      repo_url: 'https://github.com/edited-project-repo-url',
      live_preview_url: 'http://edited-live-preview-url.com'
    }
  end

  before do
    Flipper.enable(:v2_project_submissions)

    sign_in(user)
    visit lesson_path(lesson)
    Pages::ProjectSubmissions::Form.new.open.fill_in.submit
  end

  after do
    Flipper.disable(:v2_project_submissions)
  end

  it 'successfully edits a submission' do
    users_submission = first(:test_id, 'submission-item')

    within(users_submission) do
      find(:test_id, 'submission-action-menu-btn').click
      find(:test_id, 'edit-submission').click
    end

    Pages::ProjectSubmissions::Form.new(**edited_field_values).tap do |form|
      form.fill_in
      form.submit
    end

    # We need to find the user submission again because it is replaced by a turbo stream
    users_submission = first(:test_id, 'submission-item')

    within(users_submission) do
      expect(users_submission).to have_content(user.username)
      expect(users_submission.find(:test_id, 'view-code-btn')['href']).to eq('https://github.com/edited-project-repo-url')
      expect(users_submission.find(:test_id, 'live-preview-btn')['href']).to eq('http://edited-live-preview-url.com/')
    end
  end
end
