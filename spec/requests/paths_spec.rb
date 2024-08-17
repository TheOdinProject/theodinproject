require 'rails_helper'

RSpec.describe 'Paths' do
  describe 'GET #path' do
    context 'when path has more than one course' do
      it 'renders the path page' do
        path = create(:path)
        create(:course, path:)
        create(:course, path:)

        get path_url(path)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when path only has one course' do
      it 'redirects to the course' do
        path = create(:path)
        course = create(:course, path:)

        get path_url(path)

        expect(response).to redirect_to(path_course_path(path, course))
      end
    end
  end
end
