require 'rails_helper'

RSpec.describe 'Preview Pages', type: :request do
  describe 'GET #show' do
    it 'renders a view' do
      get lessons_preview_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'saves a preview_link' do
      expect do
        post lessons_preview_path(content: '# hello')
      end.to change { LessonPreview.count }.by(1)
    end
  end
end
