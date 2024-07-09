require 'rails_helper'

# To update all snapshots run: `UPDATE_SNAPSHOTS=true rspec spec/builders/tailwind_form_builder_spec.rb`

class TestHelper < ActionView::Base
  include Classy::Yaml::Helpers
  include InlineSvg::ActionView::Helpers
end

RSpec.describe TailwindFormBuilder do
  subject(:builder) { described_class.new(:user, user, TestHelper.new(nil, [], nil), {}) }

  let(:user) { User.new }

  describe '#text_field' do
    it 'returns a tailwind styled text field' do
      expect(builder.text_field(:username)).to match_snapshot('tailwind_form_builder/text_field')
    end

    context 'when the text field includes a leading icon' do
      it 'returns a tailwind styled text field' do
        expect(builder.text_field(:username, leading_icon: true))
          .to match_snapshot('tailwind_form_builder/text_field_with_leading_icon')
      end
    end

    context 'when the options contains classes' do
      it 'append the class to the text field' do
        expect(builder.text_field(:username, { class: 'test-class' }))
          .to match_snapshot('tailwind_form_builder/text_field_with_class')
      end
    end

    context 'when the field has errors' do
      it 'returns the error message' do
        user.errors.add(:username, 'is invalid')

        expect(builder.text_field(:username)).to include('is invalid')
      end
    end
  end

  describe '#email_field' do
    it 'returns a tailwind styled email field' do
      expect(builder.email_field(:email)).to match_snapshot('tailwind_form_builder/email_field')
    end

    context 'when the field has errors' do
      it 'includes the error message' do
        user.errors.add(:email, 'is invalid')

        expect(builder.email_field(:email)).to include('is invalid')
      end
    end
  end

  describe '#date_field' do
    it 'returns a tailwind styled date field' do
      expect(builder.date_field(:created_at)).to match_snapshot('tailwind_form_builder/date_field')
    end

    context 'when the field has errors' do
      it 'includes the error message' do
        user.errors.add(:created_at, 'is invalid')

        expect(builder.date_field(:created_at)).to include('is invalid')
      end
    end
  end

  describe '#password_field' do
    it 'returns a tailwind styled password field' do
      expect(builder.password_field(:password)).to match_snapshot('tailwind_form_builder/password_field')
    end

    context 'when the field has errors' do
      it 'includes the error message' do
        user.errors.add(:password, 'is invalid')
        expect(builder.password_field(:password)).to include('is invalid')
      end
    end
  end

  describe '#text_area' do
    it 'returns a tailwind styled text area' do
      expect(builder.text_area(:username)).to match_snapshot('tailwind_form_builder/text_area')
    end

    context 'when the text area has errors' do
      it 'includes the error message' do
        user.errors.add(:username, 'is invalid')

        expect(builder.text_area(:username)).to include('is invalid')
      end
    end
  end

  describe '#label' do
    it 'returns a tailwind styled label' do
      expect(builder.label(:username, 'Some Text')).to match_snapshot('tailwind_form_builder/label')
    end
  end

  describe '#check_box' do
    it 'returns a tailwind styled check box' do
      expect(builder.check_box(:username)).to match_snapshot('tailwind_form_builder/check_box')
    end
  end
end
