require 'rails_helper'

RSpec.describe AnnouncementComponent, type: :component do
  context 'with an announcement' do
    it 'renders the announcement' do
      announcement = create(:announcement, message: 'Hello, world!')
      component = described_class.new(announcement:)

      render_inline(component)

      expect(page).to have_content('Hello, world!')
    end
  end

  context 'with no announcement' do
    it 'does not render anything' do
      component = described_class.new(announcement: nil)
      expect(render_inline(component).inner_html).to eq('')
    end
  end

  context 'when the announcement has a learn more url' do
    it 'renders the learn more link' do
      announcement = create(:announcement, learn_more_url: 'https://example.com')
      component = described_class.new(announcement:)

      render_inline(component)

      expect(page).to have_link('Learn more', href: 'https://example.com')
    end
  end

  context 'when the announcement does not have a learn more url' do
    it 'renders the announcement without a learn more link' do
      announcement = create(:announcement, learn_more_url: nil)
      component = described_class.new(announcement:)

      render_inline(component)

      expect(page).not_to have_link('Learn more')
    end
  end

  context 'when the announcement is closeable' do
    it 'does not render the close button' do
      announcement = create(:announcement)
      component = described_class.new(announcement:, closeable: true)

      render_inline(component)

      expect(page).to have_css("[data-test-id='announcement-close-button']")
    end
  end

  context 'when the announcement is not closeable' do
    it 'does not render the close button' do
      announcement = create(:announcement)
      component = described_class.new(announcement:, closeable: false)

      render_inline(component)

      expect(page).not_to have_css("[data-test-id='announcement-close-button']")
    end
  end
end
