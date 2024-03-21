require 'rails_helper'

RSpec.describe Theme::SwitcherComponent, type: :component do
  context 'when dark mode is enabled' do
    it 'renders the moon icon' do
      component = described_class.new(current_theme: Users::Theme.for('dark'))

      render_inline(component)

      expect(page).to have_css('title', text: 'moon')
    end
  end

  context 'when system mode is not enabled' do
    it 'renders the computer desktop icon' do
      component = described_class.new(current_theme: Users::Theme.for('system'))

      render_inline(component)

      expect(page).to have_css('title', text: 'computer-desktop')
    end
  end
end
