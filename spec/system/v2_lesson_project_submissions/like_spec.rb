require 'rails_helper'

RSpec.describe 'Liking project submissions' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }

  before do
    Flipper.enable(:v2_project_submissions)
    create(:project_submission, lesson:)

    sign_in(user)
    visit lesson_path(lesson)
  end

  after do
    Flipper.disable(:v2_project_submissions)
  end

  it 'you can like another users submission' do
    within(:test_project_submission, 1) do
      expect(find(:test_id, 'like-count')).to have_content('0')
      find(:test_id, 'like-submission').click
      expect(find(:test_id, 'like-count')).to have_content('1')
    end
  end

  it 'you can unlike another users submission' do
    within(:test_project_submission, 1) do
      find(:test_id, 'like-submission').click
      expect(find(:test_id, 'like-count')).to have_content('1')
      find(:test_id, 'like-submission').click
      expect(find(:test_id, 'like-count')).to have_content('0')
    end
  end
end
