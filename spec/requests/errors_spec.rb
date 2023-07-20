require 'rails_helper'

RSpec.describe 'Error Pages' do
  describe 'GET 404' do
    it 'returns the correct status code' do
      get '/404'
      expect(response).to have_http_status(:not_found)
    end

    it 'returns the correct page' do
      get '/404'
      expect(response.body).to include('Looks like you\'re lost, Odinite!')
    end
  end

  describe 'GET 422' do
    it 'returns the correct status code' do
      get '/422'
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns the correct page' do
      get '/422'
      expect(response.body).to include('The change you wanted was rejected. Maybe you tried to change something')
    end
  end

  describe 'GET 500' do
    it 'returns the correct status code' do
      get '/500'
      expect(response).to have_http_status(:internal_server_error)
    end

    it 'returns the correct page' do
      get '/500'
      expect(response.body).to include('We\'re sorry, but something went wrong.')
    end
  end
end
