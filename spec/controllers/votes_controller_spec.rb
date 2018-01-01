require 'rails_helper'

RSpec.describe VotesController do

  let(:project) { double('Project', user: other_user) }

  let(:params) {
    {
      lesson_id: '1',
      project_id: project_id
    }
  }

  let(:user) { double('User') }
  let(:other_user) { double('User') }
  let(:project_id) { '1' }
  let(:user_signed_in?) { true }

  before do
    allow(Project).to receive(:find).with(project_id).and_return(project)

    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:user_signed_in?).and_return(user_signed_in?)
    allow(project).to receive(:upvote_for).with(user)
    allow(project).to receive(:remove_vote_for).with(user)
  end

  describe '#create' do
    it 'creates a new user vote for the project' do
      post :create, params: params, format: :js
      expect(project).to have_received(:upvote_for).with(user)
    end

    context 'when user is not signed in' do
      let(:user_signed_in?) { false }

      it 'does not create a new vote for the project' do
        post :create, params: params, format: :js
        expect(project).to_not have_received(:upvote_for).with(user)
      end
    end

    context 'returns bad request when user tries to vote his own project' do
      before do
        allow(controller).to receive(:current_user).and_return(:other_user)
        post :create, params: params, format: :js
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    it 'removes the users vote for the project' do
      delete :destroy, params: params, format: :js
      expect(project).to have_received(:remove_vote_for).with(user)
    end

    context 'when user is not signed in' do
      let(:user_signed_in?) { false }

      it 'does not create a new vote for the project' do
        delete :destroy, params: params, format: :js
        expect(project).to_not have_received(:remove_vote_for).with(user)
      end
    end
  end
end
