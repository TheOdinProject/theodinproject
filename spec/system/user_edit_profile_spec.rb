require 'rails_helper'

RSpec.describe 'Edit settings page details:', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in(user)
    visit edit_user_registration_path
  end

  it 'edits name & email on settings page' do
    find(:test_id, 'user-edit-profile-btn').click
    find(:test_id, 'edit-username-input').fill_in(with: 'coolben')
    find(:test_id, 'edit-user-email-field').fill_in(with: 'benscool@gmail.com')
    find(:test_id, 'edit-user-submit-btn').click

    expect(find(:test_id, 'settings-view-username')).to have_content('coolben')
    expect(find(:test_id, 'settings-view-email')).to have_content('benscool@gmail.com')
  end

  it 'validates edit name & email on settings page' do
    find(:test_id, 'user-edit-profile-btn').click
    find(:test_id, 'edit-username-input').fill_in(with: 'zz')
    find(:test_id, 'edit-user-email-field').fill_in(with: 'zz')
    find(:test_id, 'edit-user-submit-btn').click

    expect(page).to have_content('is not a valid email')
    expect(page).to have_content('is too short (minimum is 4 characters)')
  end

  it 'edits learning goal' do
    find(:test_id, 'user-edit-learning-goal-btn').click
    find(:test_id, 'edit-learning-goal-text-field').fill_in(with: 'i want to be a super cool pro coder')
    find(:test_id, 'edit-learning-goal-submit-btn').click

    expect(find(:test_id, 'settings-view-learning-goal')).to have_content('i want to be a super cool pro coder')
  end

  it 'validates edit learning goal' do
    find(:test_id, 'user-edit-learning-goal-btn').click
    find(:test_id, 'edit-learning-goal-text-field').fill_in(with: 'yo')
    find('body').click

    expect(page).to have_content('is too short (minimum is 4 characters)')
  end

  it 'validates change password' do
    find(:test_id, 'edit-password').click
    find(:test_id, 'password_field').fill_in(with: 'yo')
    find(:test_id, 'password_field_confirm').fill_in(with: 'sup')
    find('body').click

    expect(page).to have_content('is too short (minimum is 6 characters)')
    expect(page).to have_content('The passwords do not match')
  end
end
