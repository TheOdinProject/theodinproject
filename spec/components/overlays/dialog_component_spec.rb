require 'rails_helper'

RSpec.describe Overlays::DialogComponent, type: :component do
  it 'renders' do
    component = described_class.new(id: 'test-dialog')

    render_inline(component)

    expect(page).to have_css('#test-dialog')
  end
end
