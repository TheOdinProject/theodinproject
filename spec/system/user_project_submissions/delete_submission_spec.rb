require 'rails_helper'

RSpec.describe 'Deleting a Project Submission on the Dashboard' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }

  before do
    create(:project_submission, user:, lesson:)
    sign_in(user)
    visit dashboard_path
  end

  it 'successfully deletes a submission' do
    sleep 0.1 # it will not open the dropdown without this
    within(:test_id, 'user-submissions-list') do
      expect(page).to have_content(lesson.title)
    end

    find(:test_id, 'submission-action-menu-btn').click

    page.accept_confirm do
      find(:test_id, 'delete-submission').click
    end

    within(:test_id, 'user-submissions-list') do
      expect(page).to have_no_content(lesson.title)
    end
  end
end
