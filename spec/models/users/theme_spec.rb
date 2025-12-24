require 'rails_helper'

RSpec.describe Users::Theme do
  describe '.default_themes' do
    it 'returns the default themes' do
      expect(described_class.default_themes).to contain_exactly(
        an_object_having_attributes(name: 'light', icon: 'moon'),
        an_object_having_attributes(name: 'dark', icon: 'sun')
      )
    end
  end

  describe '.exists?' do
    context 'when the theme exists' do
      it 'returns true' do
        expect(described_class.exists?('light')).to be true
      end
    end

    context 'when the theme does not exist' do
      it 'returns false' do
        expect(described_class.exists?('foo')).to be false
      end
    end
  end

  describe '.for' do
    it 'returns the theme for the given name' do
      expect(described_class.for('dark')).to have_attributes(name: 'dark', icon: 'sun')
    end
  end

  describe '#to_s' do
    it 'returns the theme name' do
      expect(described_class.new(name: 'light', icon: 'moon').to_s).to eq('light')
    end
  end

  describe '#dark_mode?' do
    context 'when the theme is dark' do
      it 'returns true' do
        expect(described_class.new(name: 'dark', icon: 'sun')).to be_dark_mode
      end
    end

    context 'when the theme is light' do
      it 'returns false' do
        expect(described_class.new(name: 'light', icon: 'moon')).not_to be_dark_mode
      end
    end
  end
end
