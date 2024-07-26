require 'rails_helper'

RSpec.describe Reports::Period do
  describe '.all' do
    it 'returns all valid periods' do
      periods = described_class.all

      expect(periods.map(&:name)).to eq(%w[day month year])
    end
  end

  describe '.find' do
    context 'when period with the same name is found' do
      it 'returns the period' do
        expect(described_class.find('day')).to eq(described_class.new('day'))
      end
    end

    context "when a period can't be found" do
      it 'returns the period' do
        expect(described_class.find('eon')).to be_nil
      end
    end
  end

  describe '#as_option' do
    it 'returns the period in a format for rails select form fields' do
      expect(described_class.new('day').as_option).to eq(%w[Day day])
    end
  end
end
