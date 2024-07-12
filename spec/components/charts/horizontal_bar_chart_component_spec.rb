require 'rails_helper'

RSpec.describe Charts::HorizontalBarChartComponent, type: :component do
  context 'when the dataset is smaller than 5' do
    it 'renders the chart with an appropiate height' do
      component = described_class.new(labels: %w[A B], datasets: [1, 2])

      render_inline(component)

      expect(page).to have_css('div', style: 'height: 80px;')
    end
  end

  context 'when the dataset is larger than 5' do
    it 'renders the chart with an appropiate height' do
      component = described_class.new(labels: %w[A B C D E F], datasets: [1, 2, 3, 4, 5, 6])

      render_inline(component)

      expect(page).to have_css('div', style: 'height: 150px;')
    end
  end
end
