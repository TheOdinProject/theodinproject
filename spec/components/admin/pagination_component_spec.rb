require 'rails_helper'

RSpec.describe Admin::PaginationComponent, type: :component do
  context 'when there is more than one page' do
    it 'renders the pagination component' do
      with_request_url('/admin_v2/flags') do
        pagy = instance_double(Pagy, pages: 3, next: 3, prev: 1, from: 1, to: 10, count: 30)
        component = described_class.new(pagy:, resource_name: 'flags')

        render_inline(component)

        expect(page).to have_content('Previous')
        expect(page).to have_content('Next')
      end
    end
  end

  context 'when there is only one page' do
    it 'does not render the pagination component' do
      with_request_url('/admin_v2/flags') do
        pagy = instance_double(Pagy, pages: 1, next: nil, prev: nil, from: 1, to: 10, count: 10)
        component = described_class.new(pagy:, resource_name: 'flags')

        render_inline(component)

        expect(page).not_to have_content('Previous')
        expect(page).not_to have_content('Next')
      end
    end
  end
end
