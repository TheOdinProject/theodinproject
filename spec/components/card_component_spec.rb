require 'rails_helper'

RSpec.describe CardComponent, type: :component do
  it 'renders the card with custom classes' do
    component = described_class.new(classes: 'a-class')

    render_inline(component)

    expect(page).to have_css('div.a-class')
  end

  it 'renders the card with an id' do
    component = described_class.new(id: 'an-id')

    render_inline(component)

    expect(page).to have_css('div#an-id')
  end
end
