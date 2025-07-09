require 'rails_helper'

RSpec.describe 'Admin flags' do
  let!(:flag) { create(:flag, project_submission:) }
  let(:project_submission) { create(:project_submission, lesson:, user: submission_owner) }
  let(:lesson) { create(:lesson, is_project: true, accepts_submission: true, previewable: true) }
  let(:submission_owner) { create(:user, username: 'Simon Bell', email: 'simon@example.com', password: 'pa55word') }

  before do
    sign_in(create(:admin_user))
    visit admin_flags_path

    within("#flag_#{flag.id}") do
      click_on('View')
    end
  end

  context 'when dismissing the flag' do
    it 'dismisses the flag' do
      click_on('Resolve flag')
      choose('action_taken_dismiss')
      click_on('Submit')

      expect(page).to have_content('Flag dismissed')

      within(:test_id, 'flag-status') do
        expect(page).to have_content('Dismissed')
      end

      # resolve button is hidden
      expect(page).not_to have_selector(:link_or_button, 'Resolve flag')

      # flag is in resolved list
      visit admin_flags_path(status: 'resolved')
      expect(find("#flag_#{flag.id}")).to be_present
    end
  end

  context 'when removing the submission' do
    it 'removes the project submission' do
      click_on('Resolve flag')
      choose('action_taken_removed_project_submission')
      click_on('Submit')

      expect(page).to have_content('Project submission removed')

      within(:test_id, 'flag-status') do
        expect(page).to have_content('Project submission removed')
      end

      # resolve button is hidden
      expect(page).not_to have_selector(:link_or_button, 'Resolve flag')

      # flag is in resolved list
      visit admin_flags_path(status: 'resolved')
      expect(find("#flag_#{flag.id}")).to be_present

      # removes the project solution from the submission list
      using_session('learner') do
        sign_in(create(:user))
        visit lesson_project_submissions_path(lesson)

        within(:test_id, 'submissions-list') do
          expect(page).not_to have_content(submission_owner.username)
        end
      end
    end
  end

  context 'when banning the submission owner' do
    it 'bans the project submission owner' do
      click_on('Resolve flag')
      choose('action_taken_ban')
      click_on('Submit')

      expect(page).to have_content('Project submission owner has been banned')

      within(:test_id, 'flag-status') do
        expect(page).to have_content('Banned')
      end

      # resolve button is hidden
      expect(page).not_to have_selector(:link_or_button, 'Resolve flag')

      # flag is in resolved list
      visit admin_flags_path(status: 'resolved')
      expect(find("#flag_#{flag.id}")).to be_present

      # The flagged project submission is not visible to other users
      using_session('learner') do
        sign_in(create(:user))
        visit lesson_project_submissions_path(lesson)

        within(:test_id, 'submissions-list') do
          expect(page).not_to have_content(submission_owner.username)
        end
      end

      # prohibits the banned user from signing in again
      using_session('the_banned_user') do
        visit new_user_session_path
        find(:test_id, 'email-field').fill_in(with: submission_owner.email)
        find(:test_id, 'password-field').fill_in(with: submission_owner.password)
        find(:test_id, 'submit-btn').click

        expect(page).to have_current_path(new_user_session_path)
        expect(find(:test_id, 'flash')).to have_text('Your user account has been banned')
      end
    end
  end

  context 'when notifying the submission owner of a broken link' do
    it 'gives the admin feedback to let them know the user has been notified' do
      click_on('Resolve flag')
      choose('action_taken_notified_user')
      click_on('Submit')

      expect(page).to have_content('Notification sent')

      within(:test_id, 'flag-status') do
        expect(page).to have_content('Notified')
      end

      # resolve button is hidden
      expect(page).not_to have_selector(:link_or_button, 'Resolve flag')

      # flag is in resolved list
      visit admin_flags_path(status: 'resolved')
      expect(find("#flag_#{flag.id}")).to be_present
    end
  end
end
