require 'rails_helper'

RSpec.describe 'Lessons' do
  describe 'GET #show' do
    let(:course) { create(:course, path: create(:path, default_path: true)) }
    let(:section) { create(:section, course:) }
    let(:lesson) { create(:lesson, section:) }

    it 'loads the course-contents sidebar frame eagerly instead of deferring it until it is opened' do
      get lesson_path(lesson)

      expect(response).to have_http_status(:success)

      frame_tag = response.body[/<turbo-frame[^>]*id="lesson-sidebar-frame"[^>]*>/]
      expect(frame_tag).not_to be_nil
      expect(frame_tag).not_to include('loading="lazy"')
    end
  end
end
