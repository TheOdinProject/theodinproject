require 'rails_helper'

RSpec.describe 'Liking project submissions' do
  let(:lesson) { create(:lesson, :project) }
  let(:user_lesson) { create(:lesson, :project) }

  context 'when the submission has no likes' do
    let(:user) { create(:user, created_at: 15.days.ago) }

    before do
      create(:project_submission, lesson:)

      sign_in(user)
      visit lesson_path(user_lesson)

      Pages::ProjectSubmissions::Form.new.open.fill_in.submit
      visit lesson_path(lesson)
    end

    it 'you can like and unlike another users submission' do
      within(:test_project_submission, 1) do
        expect(find(:test_id, 'like-count')).to have_content('0')

        policy = SubmissionVotePolicy.new(user)
        puts policy.allowed?

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
    let(:user) { create(:user, created_at: 15.days.ago) }

    before do
      create(:project_submission, lesson:, likes_count: 10)

      sign_in(user)
      visit lesson_path(user_lesson)

      Pages::ProjectSubmissions::Form.new.open.fill_in.submit
      visit lesson_path(lesson)
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

  context 'when submission has no likes and user is too young' do
    let(:user) { create(:user) }

    before do
      create(:project_submission, lesson:)

      sign_in(user)
      visit lesson_path(lesson)
    end

    it 'cannot like the submission' do
      within(:test_project_submission, 1) do
        expect(find(:test_id, 'like-count')).to have_content('0')

        find(:test_id, 'like-submission').click
        expect(find(:test_id, 'like-count')).to have_content('0')
      end
    end
  end
end
