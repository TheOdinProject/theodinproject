require 'rails_helper'

RSpec.describe Flags::Action do
  describe '.all' do
    it 'returns all available flag actions' do
      expect(described_class.all.map(&:value)).to eq(
        I18n.t('flag_actions').pluck(:value)
      )
    end
  end

  describe '.for' do
    it 'returns the flag action for the given value' do
      expect(described_class.for('dismiss').value).to eq('dismiss')
    end
  end
end
