require 'rails_helper'

RSpec.describe 'Error Pages' do
  describe 'GET 404' do
    it 'returns the correct status code' do
      get '/404'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET 422' do
    it 'returns the correct status code' do
      get '/422'
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET 500' do
    it 'returns the correct status code' do
      get '/500'
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
