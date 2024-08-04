require 'rails_helper'

RSpec.describe 'Admin users passwords' do
  describe 'GET #new' do
    it 'redirects to the admin sign in page' do
      get new_admin_user_password_path

      expect(response).to redirect_to(new_admin_user_session_path)
      expect(flash[:alert]).to eq('Please sign in')
    end
  end

  describe 'POST #create' do
    it 'redirects to the admin sign in page' do
      post admin_user_password_path

      expect(response).to redirect_to(new_admin_user_session_path)
      expect(flash[:alert]).to eq('Please sign in')
    end
  end
end
