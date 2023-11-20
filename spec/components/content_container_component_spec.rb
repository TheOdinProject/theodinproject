require 'rails_helper'

RSpec.describe ContentContainerComponent, type: :component do
  it 'renders content' do
    component = described_class.new

    render_inline(component) { 'Some riveting content' }

    expect(page).to have_content('Some riveting content')
  end

  it 'renders content with classes' do
    component = described_class.new(classes: 'some-class')

    render_inline(component) { 'Some riveting content' }

    expect(page).to have_css('.some-class')
  end

  it 'renders content with data attributes' do
    component = described_class.new(data_attributes: { some_attribute: 'some-value' })

    render_inline(component) { 'Some riveting content' }

    expect(page).to have_css("[data-some-attribute='some-value']")
  end
end
