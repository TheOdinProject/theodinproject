require 'rails_helper'

RSpec.describe 'Community Guides' do
  describe 'GET #show' do
    it 'renders the community guides' do
      get guides_community_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #rules' do
    it 'renders the community rules guide' do
      get rules_guides_community_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #expectations' do
    it 'renders the community expectations guide' do
      get expectations_guides_community_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #how_to_ask' do
    it 'renders the how to ask technical questions guide' do
      get how_to_ask_guides_community_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #before_asking' do
    it 'renders the help yourself before asking guide' do
      get before_asking_guides_community_path

      expect(response).to have_http_status(:ok)
    end
  end
end
