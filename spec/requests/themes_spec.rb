require 'rails_helper'

RSpec.describe 'Themes' do
  describe 'PUT #update' do
    before do
      cookies[:theme] = 'light'
    end

    context 'when the theme is valid' do
      it 'switches themes' do
        expect do
          put themes_path(format: :turbo_stream, params: { theme: 'dark' })
        end.to change { cookies[:theme] }.from('light').to('dark')
      end
    end

    context 'when the theme is invalid' do
      it "doesn't switch themes" do
        expect do
          put themes_path(format: :turbo_stream, params: { theme: 'invalid' })
        end.not_to change { cookies[:theme] }
      end
    end
  end
end
