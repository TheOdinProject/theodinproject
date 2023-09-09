require 'rails_helper'

RSpec.describe Team::FormerMemberComponent, type: :component do
  let(:former_member) do
    {
      image: 'https://example.com/avatar.png',
      name: 'John Doe',
      url: 'https://example.com'
    }
  end

  it 'renders the former team members avatar' do
    component = described_class.new(former_member)

    render_inline(component)

    expect(page).to have_css('img[src="https://example.com/avatar.png"]')
  end

  it 'renders the former team members name' do
    component = described_class.new(former_member)

    render_inline(component)

    expect(page).to have_content('John Doe')
  end

  it 'renders the former team members url' do
    component = described_class.new(former_member)

    render_inline(component)

    expect(page).to have_link(href: 'https://example.com')
  end
end
