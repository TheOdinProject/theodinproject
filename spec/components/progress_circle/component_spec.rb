require 'rails_helper'

RSpec.describe ProgressCircle::Component, type: :component do
  context 'when percentatge is 0' do
    it 'reners 0%' do
      component = described_class.new(percentage: 0)

      render_inline(component)

      expect(page).to have_text('0% Complete')
    end
  end

  context 'when percentage is 33' do
    it 'renders 33%' do
      component = described_class.new(percentage: 33)

      render_inline(component)

      expect(page).to have_text('33% Complete')
    end
  end

  context 'when percentatge is 100' do
    it 'reners 100%' do
      component = described_class.new(percentage: 100)

      render_inline(component)

      expect(page).to have_text('100% Complete')
    end
  end
end
