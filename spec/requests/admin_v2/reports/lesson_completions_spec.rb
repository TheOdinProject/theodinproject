require 'rails_helper'

RSpec.describe 'Reports - Lesson completions' do
  describe 'GET #show' do
    context 'when signed in as an admin' do
      it 'renders the lesson completions report' do
        admin = create(:admin_user)
        sign_in(admin)

        get admin_v2_reports_lesson_completions_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the sign in page' do
        get admin_v2_reports_lesson_completions_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end
end
