require 'rails_helper'

RSpec.describe Team::MemberComponent, type: :component do
  let(:team_member) do
    {
      image: 'https://example.com/avatar.png',
      name: 'John Doe',
      location: 'Berlin',
      joined: '2019',
      socials: [
        { name: 'twitter', url: 'https://twitter.com' },
        { name: 'github', url: 'https://github.com' },
        { name: 'linkedin', url: 'https://linkedin.com' },
        { name: 'website', url: 'https://example.com' }
      ]
    }
  end

  it 'renders the team members avatar' do
    component = described_class.new(team_member)

    render_inline(component)

    expect(page).to have_css('img[src="https://example.com/avatar.png"]')
  end

  it 'renders the team members name' do
    component = described_class.new(team_member)

    render_inline(component)

    expect(page).to have_content('John Doe')
  end

  it 'renders the team members meta data' do
    component = described_class.new(team_member)

    render_inline(component)

    expect(page).to have_content('Berlin')
    expect(page).to have_content('2019')
  end

  it 'renders the team members socials' do
    component = described_class.new(team_member)

    render_inline(component)

    expect(page).to have_link('twitter', href: 'https://twitter.com')
    expect(page).to have_link('github', href: 'https://github.com')
    expect(page).to have_link('linkedin', href: 'https://linkedin.com')
    expect(page).to have_link('website', href: 'https://example.com')
  end

  context 'when the team member has no socials' do
    it 'does not render any social links' do
      team_member = { name: 'John Doe', image: 'https://example.com/avatar.png', location: 'Berlin', joined: '2019' }
      component = described_class.new(team_member)

      render_inline(component)

      expect(page).to have_no_link('twitter', href: 'https://twitter.com')
      expect(page).to have_no_link('github', href: 'https://github.com')
      expect(page).to have_no_link('linkedin', href: 'https://linkedin.com')
      expect(page).to have_no_link('website', href: 'https://example.com')
    end
  end
end
