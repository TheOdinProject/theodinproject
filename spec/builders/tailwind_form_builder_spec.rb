require 'rails_helper'

class TestHelper < ActionView::Base
  include Classy::Yaml::Helpers
  include InlineSvg::ActionView::Helpers
end

RSpec.describe TailwindFormBuilder do
  subject(:builder) { described_class.new(:user, user, TestHelper.new(nil, [], nil), {}) }

  let(:user) { User.new }

  describe '#text_field' do
    it 'returns a tailwind styled text field' do
      expected_html = <<~HTML
        <div class="mt-1 relative rounded-md shadow-sm">
        <input class="block w-full border rounded-md py-2 px-3 focus:outline-none border-gray-300 focus:ring-blue-600 focus:border-blue-600" type="text" name="user[username]" id="user_username" />
        </div>
        <div class="mt-2 text-sm text-red-600 hidden"></div>
      HTML

      expect(builder.text_field(:username)).to eq(expected_html.delete("\n"))
    end

    context 'when the options contains classes' do
      it 'append the class to the text field' do
        expected_html = <<~HTML
          <div class="mt-1 relative rounded-md shadow-sm">
          <input class="block w-full border rounded-md py-2 px-3 focus:outline-none border-gray-300 focus:ring-blue-600 focus:border-blue-600 test-class" type="text" name="user[username]" id="user_username" />
          </div>
          <div class="mt-2 text-sm text-red-600 hidden"></div>
        HTML

        expect(builder.text_field(:username, { class: 'test-class' })).to eql(expected_html.delete("\n"))
      end
    end

    context 'when the field has errors' do
      before do
        user.errors.add(:username, 'is invalid')
      end

      it 'returns the error message' do
        expect(builder.text_field(:username)).to include('is invalid')
      end
    end
  end

  describe '#email_field' do
    it 'returns a tailwind styled email field' do
      expected_html = <<~HTML
        <div class="mt-1 relative rounded-md shadow-sm">
        <input class="block w-full border rounded-md py-2 px-3 focus:outline-none border-gray-300 focus:ring-blue-600 focus:border-blue-600" type="email" value="" name="user[email]" id="user_email" />
        </div>
        <div class="mt-2 text-sm text-red-600 hidden"></div>
      HTML

      expect(builder.email_field(:email)).to eql(expected_html.delete("\n"))
    end

    context 'when the field has errors' do
      before do
        user.errors.add(:email, 'is invalid')
      end

      it 'includes the error message' do
        expect(builder.email_field(:email)).to include('is invalid')
      end
    end
  end

  describe '#password_field' do
    it 'returns a tailwind styled password field' do
      expected_html = <<~HTML
        <div class="mt-1 relative rounded-md shadow-sm">
        <input class="block w-full border rounded-md py-2 px-3 focus:outline-none border-gray-300 focus:ring-blue-600 focus:border-blue-600" type="password" name="user[password]" id="user_password" />
        </div>
        <div class="mt-2 text-sm text-red-600 hidden"></div>
      HTML

      expect(builder.password_field(:password)).to eql(expected_html.delete("\n"))
    end

    context 'when the field has errors' do
      before do
        user.errors.add(:password, 'is invalid')
      end

      it 'includes the error message' do
        expect(builder.password_field(:password)).to include('is invalid')
      end
    end
  end

  describe '#text_area' do
    it 'returns a tailwind styled text area' do
      expected_html = <<~HTML
        <div class="mt-1 relative rounded-md shadow-sm"><textarea class="mt-1 block w-full border rounded-md py-2 px-3 focus:outline-none border-gray-300 focus:ring-blue-600 focus:border-blue-600" name="user[username]" id="user_username">
        </textarea></div><div class="mt-2 text-sm text-red-600 hidden"></div>
      HTML

      expect(builder.text_area(:username)).to eql(expected_html.strip)
    end

    context 'when the text area has errors' do
      before do
        user.errors.add(:username, 'is invalid')
      end

      it 'includes the error message' do
        expect(builder.text_area(:username)).to include('is invalid')
      end
    end
  end

  describe '#label' do
    it 'returns a tailwind styled label' do
      expected_html = <<~HTML
        <label class="block text-sm font-medium text-gray-700 " for="user_username">Some Text</label>
      HTML

      expect(builder.label(:username, 'Some Text')).to eql(expected_html.strip)
    end
  end

  describe '#check_box' do
    it 'returns a tailwind styled check box' do
      expected_html = <<~HTML
        <input name="user[username]" type="hidden" value="0" autocomplete="off" /><input class=" h-4 w-4 border-gray-300 rounded" type="checkbox" value="1" name="user[username]" id="user_username" />
      HTML

      expect(builder.check_box(:username)).to eql(expected_html.strip)
    end
  end
end
