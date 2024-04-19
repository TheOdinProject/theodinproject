require 'rails_helper'

RSpec.describe 'Deleting a Project Submission' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }

  before do
    sign_in(user)
    visit lesson_path(lesson)
    Pages::ProjectSubmissions::Form.new.open.fill_in.submit
  end

  it 'removes a submission' do
    within(:test_id, 'current-user-solution') do
      expect(page).to have_content(lesson.title)

      find(:test_id, 'submission-action-menu-btn').click

      page.accept_confirm do
        find(:test_id, 'delete-submission').click
      end

      expect(page).to have_content('Submit your solution')
      expect(page).to have_no_content(lesson.title)
    end
  end
end
