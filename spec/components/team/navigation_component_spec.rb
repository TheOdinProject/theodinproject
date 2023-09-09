require 'rails_helper'

RSpec.describe Team::NavigationComponent, type: :component do
  it 'renders navigation links for the different roles' do
    component = described_class.new(
      roles: role = [
        { name: 'Core', url: '#core' },
        { name: 'Maintainers', url: '#maintainers' },
        { name: 'Moderators', url: '#moderators' },
        { name: 'Alumni', url: '#alumni' }
      ]
    )

    render_inline(component)

    expect(page).to have_link(href: '#core')
    expect(page).to have_link(href: '#maintainers')
    expect(page).to have_link(href: '#moderators')
    expect(page).to have_link(href: '#alumni')
  end
end
