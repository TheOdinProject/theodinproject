require 'rails_helper'

RSpec.describe 'Share preview' do
  describe 'POST #create' do
    context 'when the preview is valid' do
      it 'creates a sharable preview' do
        expect do
          post lessons_preview_share_path(content: '# hello', format: :turbo_stream)
        end.to change { LessonPreview.count }.by(1)
      end
    end

    context 'when the preview is invalid' do
      it 'does not create a sharable preview' do
        expect do
          post lessons_preview_share_path(content: '', format: :turbo_stream)
        end.not_to change { LessonPreview.count }
      end

      it 'informs the user a sharable preview cannot be created' do
        post lessons_preview_share_path(content: '', format: :turbo_stream)
        expect(response.body).to include('Unable to share preview')
      end
    end
  end
end
