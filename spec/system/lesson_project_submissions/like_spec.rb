require 'rails_helper'

RSpec.describe 'Liking project submissions' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }

  context 'when the submission has no likes' do
    before do
      create(:project_submission, lesson:)

      sign_in(user)
      create(:project_submission, user_id: user.id)

      visit lesson_project_submissions_path(lesson)
    end

    it 'you can like and unlike another users submission' do
      within(:test_project_submission, 1) do
        expect(find(:test_id, 'like-count')).to have_content('0')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('1')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('0')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('1')
      end
    end
  end

  context 'when the submission has existing likes' do
    before do
      create(:project_submission, lesson:, likes_count: 10)

      sign_in(user)
      create(:project_submission, user_id: user.id)

      visit lesson_project_submissions_path(lesson)
    end

    it 'you can like and unlike another users submission' do
      within(:test_project_submission, 1) do
        expect(find(:test_id, 'like-count')).to have_content('10')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('11')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('10')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('11')
      end
    end
  end

  context 'when a user is inflating likes' do
    before do
      create(:project_submission, lesson:)

      create(:user, last_sign_in_ip: '127.0.0.1')
      sign_in(user) # Sets current ip to localhost

      visit lesson_project_submissions_path(lesson)
    end

    it 'cannot like the submission' do
      within(:test_project_submission, 1) do
        expect(find(:test_id, 'like-count')).to have_content('0')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('0')
      end

      expect(page).to have_content('Failed to like')
    end
  end
end
