require 'rails_helper'

RSpec.describe ButtonHelper do
  before do
    allow(helper).to receive(:resource_name).and_return('user')
  end

  describe '#sign_up_button' do
    it 'returns a sign up button' do
      expect(helper.sign_up_button).to eq('<a class="button button--primary" href="/sign_up">Sign up</a>')
    end
  end

  describe '#curriculum_button' do
    it 'returns the curriculum button' do
      expect(helper.curriculum_button).to eq(
        '<a class="button button--primary text-base" href="/paths">View curriculum</a>'
      )
    end
  end

  describe '#contribute_button' do
    it 'returns a contribute button' do
      expect(helper.contribute_button).to eq(
        '<a class="button button--primary" href="/contributing">Learn how to contribute</a>'
      )
    end
  end

  describe '#chat_button' do
    let(:chat_button) do
      render NewTabLinkComponent.new(
        text: 'Open Discord',
        href: 'https://discord.gg/fbFCkYabZB',
        classes: 'button button--secondary px-4'
      )
    end

    it 'returns a chat button' do
      # https://regexr.com/8ll7q to test this regex
      id = /(?<=\sid="|\saria-labelledby=").+(?=")/

      expect(helper.chat_button.gsub(id, 'test-id')).to eq(chat_button.gsub(id, 'test-id'))
    end
  end
end
