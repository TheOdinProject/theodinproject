require 'rails_helper'

RSpec.describe NewTabTextLinkComponent, type: :component do
  it 'renders the link with a new tab svg icon' do
    component = described_class.new(
      text: 'link text',
      href: 'link href',
      classes: 'a-class'
    )

    render_inline(component)

    expect(page).to have_css('svg > desc', text: 'New tab')
  end

  it 'renders the link with an href' do
    component = described_class.new(
      text: 'link text',
      href: 'link href',
      classes: 'a-class'
    )

    render_inline(component)

    expect(page).to have_css('[href="link href"]')
  end

  it 'renders the link with a text label' do
    component = described_class.new(
      text: 'link text',
      href: 'link href',
      classes: 'a-class'
    )

    render_inline(component)

    expect(page).to have_link('link text')
  end

  it 'renders the link with target="_blank" and rel="noreferrer"' do
    component = described_class.new(
      text: 'link text',
      href: 'link href',
      classes: 'a-class'
    )

    render_inline(component)

    expect(page).to have_css('[target="_blank"]')
    expect(page).to have_css('[rel="noreferrer"]')
  end

  it 'renders the link with data attributes if provided' do
    component = described_class.new(
      text: 'link text',
      href: 'link href',
      classes: 'a-class',
      data: { test_id: 'test-id' }
    )

    render_inline(component)

    expect(page).to have_css('[data-test-id="test-id"]')
  end

  it 'omits rel attribute if noreferrer: false' do
    component = described_class.new(
      text: 'link text',
      href: 'link href',
      classes: 'a-class',
      noreferrer: false
    )

    render_inline(component)

    expect(page).to have_no_css('[rel]')
  end
end
