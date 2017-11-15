require 'rails_helper'

RSpec.describe RegistrationsController do

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:list_id) { ENV['MAILCHIMP_LIST_ID'] }
    let(:email) { 'kevin@bazfiz.com' }
    let(:user_attributes) {
      {
        username: 'kevin',
        email: email,
        password: 'foobar1',
        password_confirmation: 'foobar1',
      }
    }

    before do
      mailchimp_remove_member(email, list_id)
    end

    it 'redirects to the dashboard' do
      post :create, params: { user: user_attributes }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'registers the new user on the mailchimp mailing list', :vcr do
      post :create, params: { user: user_attributes }
      expect(mailchimp_member_exists?(email, list_id)).to eq(true)
    end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryGirl.create(:user) }
    let(:updated_attributes) {
      {
        email: 'kevin@email.com',
        current_password: user.password,
        learning_goal: 'This is me'
      }
    }

    before do
      sign_in user
    end

    it 'redirects to the home path' do
      put :update, params: { id: user.id, user: updated_attributes }
      expect(response).to redirect_to(root_path)
    end
  end
end
