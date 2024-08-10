require 'rails_helper'

RSpec.describe 'User Profile' do
  let!(:user) do
    create(
      :user,
      username: 'Jeremy Beagle',
      email: 'jezza@beagle.com',
      learning_goal: 'Learn JavaScript',
      password: 'password'
    )
  end

  before do
    sign_in(user)
    visit edit_users_profile_path
  end

  describe 'editing profile details' do
    context 'with valid details' do
      it 'updates successfully' do
        expect(find(:test_id, 'username-field').value).to eq('Jeremy Beagle')
        expect(find(:test_id, 'email-field').value).to eq('jezza@beagle.com')
        expect(find(:test_id, 'learning-goal-field').value).to eq('Learn JavaScript')

        find(:test_id, 'username-field').fill_in(with: 'Joseph Bloggs')
        find(:test_id, 'email-field').fill_in(with: 'joey@bloggs.com')
        find(:test_id, 'learning-goal-field').fill_in(with: 'Learn Ruby')
        find(:test_id, 'save-profile-btn').click

        expect(find(:test_id, 'username-field').value).to have_content('Joseph Bloggs')
        expect(find(:test_id, 'email-field').value).to have_content('joey@bloggs.com')
        expect(find(:test_id, 'learning-goal-field').value).to have_content('Learn Ruby')

        expect(user.reload.username).to eq('Joseph Bloggs')
        expect(user.reload.email).to eq('joey@bloggs.com')
        expect(user.reload.learning_goal).to eq('Learn Ruby')
      end
    end

    context 'with invalid profile details' do
      it 'validates edit username & email' do
        find(:test_id, 'username-field').fill_in(with: 'z')
        find(:test_id, 'email-field').fill_in(with: '')
        find(:test_id, 'save-profile-btn').click

        expect(page).to have_content('is too short (minimum is 2 characters)')
        expect(page).to have_content("can't be blank")
      end

      it 'successfully submits and and removes the error when fields are corrected' do
        find(:test_id, 'username-field').fill_in(with: 'Barry')
        find(:test_id, 'email-field').fill_in(with: '')
        find(:test_id, 'save-profile-btn').click

        expect(page).to have_content("can't be blank")

        find(:test_id, 'email-field').fill_in(with: 'valid@example.com')
        find(:test_id, 'save-profile-btn').click

        expect(page).to have_no_content("can't be blank")
      end
    end
  end

  describe 'deleting account' do
    context 'when the user confirms to proceed' do
      it 'deletes their account' do
        expect do
          accept_confirm do
            find(:test_id, 'user-account-delete-link').click
          end
        end.to change { User.count }.by(-1)

        expect(page).to have_current_path(new_user_session_path)
        expect(find(:test_id, 'flash')).to have_text(
          'Bye! Your account was successfully cancelled. We hope to see you again soon.'
        )
      end
    end
  end

  describe 'changing password' do
    it 'validates password fields' do
      click_on 'Password'

      find(:test_id, 'current-password-field').fill_in(with: 'password')
      find(:test_id, 'password-field').fill_in(with: 'yo')
      find(:test_id, 'password-confirmation-field').fill_in(with: 'sup')
      find(:test_id, 'save-btn').click

      expect(page).to have_content('is too short (minimum is 6 characters)')
      expect(page).to have_content("doesn't match Password")
    end
  end
end
