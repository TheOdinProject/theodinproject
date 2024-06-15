require 'rails_helper'

RSpec.describe Flags::ActionButtonComponent, type: :component do
  context 'when the flag is active' do
    it 'renders the flag action button' do
      flag = create(:flag, :active)
      component = described_class.new(flag:)

      render_inline(component)

      expect(page).to have_content('Resolve flag')
    end
  end

  context 'when the flag is resolved' do
    it 'does not render anything' do
      flag = create(:flag, :resolved)
      component = described_class.new(flag:)

      expect(render_inline(component).inner_html).to eq('')
    end
  end
end
