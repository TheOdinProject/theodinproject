require 'rails_helper'

RSpec.describe DividerComponent, type: :component do
  it 'renders the component with the provided message' do
    component = described_class.new(message: 'Quite divisive')

    render_inline(component)

    expect(page).to have_selector("[data-test-id='divider-message']", text: 'Quite divisive')
  end

  it 'renders the component without a message' do
    component = described_class.new

    render_inline(component)

    expect(page).to have_selector("[data-test-id='divider-message']", text: nil)
  end
end
