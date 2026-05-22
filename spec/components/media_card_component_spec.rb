require 'rails_helper'

RSpec.describe MediaCardComponent, type: :component do
  let(:media) do
    {
      title: 'Learn by doing',
      description: 'Build real <a href="/projects">projects</a> as you learn.',
      image_path: 'about_page/img-build.svg'
    }
  end

  it 'renders the title' do
    render_inline(described_class.new(media:))

    expect(page).to have_css('h3', text: 'Learn by doing')
  end

  it 'renders the image' do
    render_inline(described_class.new(media:))

    expect(page).to have_css('img[src*="img-build"]')
  end

  it 'renders the description as HTML' do
    render_inline(described_class.new(media:))

    expect(page).to have_css('p', text: 'Build real projects as you learn.')
    expect(page).to have_link('projects', href: '/projects')
  end

  it 'renders a card per item when used with a collection' do
    collection = [
      media,
      media.merge(title: 'Receive support from others')
    ]

    render_inline(described_class.with_collection(collection))

    expect(page).to have_css('h3', text: 'Learn by doing')
    expect(page).to have_css('h3', text: 'Receive support from others')
  end

  it 'raises when the media hash is missing a required key' do
    expect { described_class.new(media: { title: 'only title' }) }
      .to raise_error(ArgumentError)
  end
end
