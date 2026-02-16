require 'rails_helper'

RSpec.describe 'Deleting a Project Submission on the Dashboard' do
  let(:user) { create(:user) }

  before do
    create(:project_submission, user:, lesson: create(:lesson, :project, title: 'My Project'))
    create(:project_submission, user:, lesson: create(:lesson, :project, title: 'Another Project'))

    sign_in(user)
    visit dashboard_path
  end

  it 'successfully deletes a submission' do
    sleep 0.1 # it will not open the dropdown without this

    within(:test_id, 'user-submissions-list') do
      expect(page).to have_content('My Project')
      expect(page).to have_content('Another Project')
    end

    within(:test_project_submission, 2) do
      expect(page).to have_content('My Project')

      find(:test_id, 'submission-action-menu-btn').click
      find(:test_id, 'delete-submission-btn').click
      find(:test_id, 'confirm-delete-submission-btn').click
    end

    within(:test_id, 'user-submissions-list') do
      expect(page).to have_no_content('My Project')
      expect(page).to have_content('Another Project')
    end
  end
end
