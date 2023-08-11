require 'rails_helper'

RSpec.describe 'Sign in' do
  let!(:user) { create(:user, email: 'odinstudent@example.com') }

  context 'when using an email and password' do
    it 'allows the user to sign in' do
      visit root_path

      find(:test_id, 'nav-sign-in').click

      find(:test_id, 'email-field').fill_in(with: user.email)
      find(:test_id, 'password-field').fill_in(with: user.password)
      find(:test_id, 'submit-btn').click

      expect(page).to have_current_path(dashboard_path)
    end

    it "doesn't allow the user to sign in with invalid credentials" do
      visit root_path

      find(:test_id, 'nav-sign-in').click

      find(:test_id, 'email-field').fill_in(with: user.email)
      find(:test_id, 'password-field').fill_in(with: 'wrongpassword')
      find(:test_id, 'submit-btn').click

      expect(page).to have_current_path(sign_in_path)
      expect(page).to have_content('Invalid email or password.')
    end
  end

  context 'when signing in with github auth' do
    before do
      mock_oauth_provider(:github)
    end

    after do
      OmniAuth.config.mock_auth[:github] = nil
    end

    it 'signs in the user' do
      visit root_path

      find(:test_id, 'nav-sign-in').click

      find(:test_id, 'github-btn').click

      expect(page).to have_current_path(dashboard_path)
    end
  end

  context 'when signing in with google auth' do
    before do
      mock_oauth_provider(:google)
    end

    after do
      OmniAuth.config.mock_auth[:google] = nil
    end

    it 'signs in the user' do
      visit root_path

      find(:test_id, 'nav-sign-in').click

      find(:test_id, 'google-btn').click

      expect(page).to have_current_path(dashboard_path)
    end
  end
end
