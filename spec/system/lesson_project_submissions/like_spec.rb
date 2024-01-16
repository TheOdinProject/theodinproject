require 'rails_helper'

RSpec.describe 'Liking project submissions' do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, :project) }

  context 'when the submission has no likes' do
    before do
      create(:project_submission, lesson:)

      sign_in(user)
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
end
