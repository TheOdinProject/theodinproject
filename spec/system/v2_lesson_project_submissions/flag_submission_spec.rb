require 'rails_helper'

RSpec.describe 'Flagging a Project Submission' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }
  let!(:project_submission) { create(:project_submission, lesson:) }

  before do
    Flipper.enable(:v2_project_submissions)

    sign_in(user)
    visit lesson_path(lesson)
  end

  after do
    Flipper.disable(:v2_project_submissions)
  end

  it 'successfully flags a submission' do
    submission = first(:test_id, 'submission-item')

    wait_for_turbo_frame("project-submissions_lesson_#{lesson.id}") do
      within(submission) do
        find(:test_id, 'submission-action-menu-btn').click
        find(:test_id, 'report-submission').click
      end
    end

    find(:test_id, 'flag-description-field').fill_in(with: 'It contains offensive material')
    find(:test_id, 'submit-btn').click

    expect(page).to have_content('Thank you! your report has been submitted.')
    expect(project_submission.reload.flags.count).to eq(1)
  end
end
