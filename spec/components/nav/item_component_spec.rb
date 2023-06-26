require 'rails_helper'

RSpec.describe Nav::ItemComponent, type: :component do
  context 'when mobile' do
    it 'renders mobile nav item' do
      component = described_class.new(
        path: '/home',
        text: 'Home',
        test_id: 'nav-home',
        icon_path: 'icons/home.svg',
        options: { mobile: true }
      )

      render_inline(component)

      expect(page).to have_link('Home', href: '/home')
      expect(page).to have_content('Home icon')
    end
  end

  context 'when not mobile' do
    it 'renders the desktop nav item' do
      component = described_class.new(
        path: '/home',
        text: 'Home',
        test_id: 'nav-home',
        icon_path: nil,
      )

      render_inline(component)

      expect(page).to have_link('Home', href: '/home')
    end
  end

  context 'when nav item uses a different http request' do
    it 'includes the different http request' do
      component = described_class.new(
        path: '/sign_out',
        text: 'Sign out',
        test_id: 'nav-sign-out',
        icon_path: nil,
        options: { method: :delete }
      )

      render_inline(component)

      expect(page).to have_link('Sign out', href: '/sign_out')
      expect(page.find_link('Sign out')['data-turbo-method']).to eq('delete')
    end
  end
end
