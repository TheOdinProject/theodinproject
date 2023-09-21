require 'rails_helper'

RSpec.describe 'Static Pages' do
  describe 'GET #home' do
    it 'renders the home page' do
      get home_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #about' do
    it 'renders the about page' do
      get about_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #faq' do
    it 'renders the faq page' do
      get faq_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #team' do
    it 'renders the team page' do
      get team_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #terms_of_use' do
    it 'renders the terms of use page' do
      get terms_of_use_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #privacy-policy' do
    it 'renders the privacy policy page' do
      get privacy_policy_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #success stories' do
    it 'renders the success stories page' do
      get success_stories_path

      expect(response).to have_http_status(:ok)
    end
  end
end
