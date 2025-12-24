require 'rails_helper'

RSpec.describe 'User Reset Progress' do
  let!(:user) { create(:user) }
  let!(:foundations_path) { create(:path, title: 'Foundations', default_path: true) }
  let!(:foundation_course) { create(:course, title: 'Foundations', path: foundations_path) }
  let!(:rails_path) { create(:path, title: 'Rails') }
  let!(:rails_course) { create(:course, title: 'Rails', path: rails_path) }

  before do
    foundation_lesson = create(:lesson, course: foundation_course)
    rails_lesson = create(:lesson, course: rails_course)

    create(:lesson_completion, lesson: foundation_lesson, user:)
    create(:lesson_completion, lesson: rails_lesson, user:, course: rails_course)

    user.update(path: rails_path)
    sign_in(user)
    visit dashboard_path
  end

  it 'resets progress' do
    expect(user.lesson_completions.count).to eq(2)
    within(:test_id, 'skills') do
      expect(find(:test_id, 'progress-circle')).to have_text('100%')
      expect(find(:test_id, 'rails-open-btn')).to have_text('Open')
    end

    visit edit_users_profile_path

    find(:test_id, 'user-reset-progress-btn').click
    find(:test_id, 'confirm-user-reset-progress-btn').click

    visit dashboard_path

    expect(user.lesson_completions.count).to eq(0)
    within(:test_id, 'skills') do
      expect(find(:test_id, 'progress-circle')).to have_text('0%')
      expect(find(:test_id, 'foundations-start-btn')).to have_text('Start')
    end
  end

  it 'resets to the default path' do
    within(:test_id, 'skills') do
      expect(page).to have_content(rails_course.title)
    end

    visit edit_users_profile_path

    find(:test_id, 'user-reset-progress-btn').click
    find(:test_id, 'confirm-user-reset-progress-btn').click

    visit dashboard_path

    expect(user.reload.path).not_to eq(rails_path)
    within(:test_id, 'skills') do
      expect(page).to have_content(foundation_course.title)
    end
  end
end
