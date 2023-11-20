require 'rails_helper'

RSpec.describe 'Lesson preview' do
  describe 'GET #show' do
    it 'renders the preview input page' do
      get lessons_preview_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'converts the markdown to html' do
      post lessons_preview_path(markdown: 'hello world', format: :turbo_stream)
      expect(response.body).to include('<p>hello world</p>')
    end
  end
end
