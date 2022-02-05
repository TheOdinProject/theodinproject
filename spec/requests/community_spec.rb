require 'rails_helper'

RSpec.describe 'Communities', type: :request do
  let(:user) { create(:user, community_onboarded:) }

  before do
    sign_in(user)
  end

  describe 'GET /show' do
    context 'when user is not community onboarded' do
      let(:community_onboarded) { false }

      it 'returns http success' do
        get community_path

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'when user is community onboarded' do
      let(:community_onboarded) { true }

      it 'returns http success' do
        get community_path

        expect(response).to redirect_to(ODIN_CHAT_URL)
      end
    end
  end
end
