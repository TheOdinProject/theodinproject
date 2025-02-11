require 'rails_helper'

RSpec.describe 'Learners' do
  describe 'GET #index' do
    context 'when signed in as an admin' do
      it 'renders the index page' do
        admin = create(:admin_user)
        sign_in(admin)

        get admin_learners_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        sign_in(user)

        get admin_learners_path

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when signed in as an admin' do
      it 'renders the show page' do
        admin = create(:admin_user)
        learner = create(:user)
        sign_in(admin)

        get admin_learner_path(learner)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        learner = create(:user)
        sign_in(user)

        get admin_learner_path(learner)

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when signed in as an admin' do
      it 'deletes the learner' do
        admin = create(:admin_user)
        learner = create(:user)
        sign_in(admin)

        expect do
          delete admin_learner_path(learner)
        end.to change { User.count }.by(-1)

        expect(response).to redirect_to(admin_learners_path)
      end
    end

    context 'when not signed in as an admin' do
      it 'redirects to the admin sign in page' do
        user = create(:user)
        learner = create(:user)
        sign_in(user)

        expect do
          delete admin_learner_path(learner)
        end.not_to change { User.count }

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end

    context 'when the admin is not authorized to delete learners' do
      it 'redirects to learners page' do
        admin = create(:admin_user, role: 'maintainer')
        learner = create(:user)
        sign_in(admin)

        expect do
          delete admin_learner_path(learner)
        end.not_to change { User.count }

        expect(response).to redirect_to(admin_learners_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end
end
