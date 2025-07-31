require 'rails_helper'

RSpec.describe Overlays::FlashComponent, type: :component do
  context 'when the type is alert' do
    it 'renders an alert flash' do
      component = described_class.new(type: 'alert', message: 'Fire!')

      render_inline(component)

      expect(page).to have_css('.bg-red-100')
      expect(page).to have_content('Fire!')
    end
  end

  context 'when the type is notice' do
    it 'renders a notice flash' do
      component = described_class.new(type: 'notice', message: 'Success!')

      render_inline(component)

      expect(page).to have_css('.bg-green-100')
      expect(page).to have_content('Success!')
    end
  end

  context 'when the type is dissallowed' do
    it 'does not render the flash' do
      component = described_class.new(type: 'timedout', message: 'Timed out')

      expect(render_inline(component).inner_html).to eq('')
    end
  end
end
