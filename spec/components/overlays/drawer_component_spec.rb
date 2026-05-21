require 'rails_helper'

RSpec.describe Overlays::DrawerComponent, type: :component do
  it 'renders yielded content' do
    render_inline(described_class.new(hook_class: 'off-canvas-menu', aria_label: 'Navigation')) { 'drawer content' }

    expect(page).to have_content('drawer content')
  end

  it 'renders the close button with the given label' do
    render_inline(
      described_class.new(
        hook_class: 'off-canvas-menu',
        aria_label: 'Navigation',
        close_label: 'Close menu'
      )
    )

    expect(page).to have_css('button[data-action="click->visibility#off"]')
    expect(page).to have_css('.sr-only', text: 'Close menu')
  end

  it 'renders aria-label on the dialog' do
    render_inline(described_class.new(hook_class: 'off-canvas-menu', aria_label: 'Navigation'))

    expect(page).to have_css('[role="dialog"][aria-label="Navigation"]')
  end

  it 'requires aria_label' do
    expect { described_class.new(hook_class: 'off-canvas-menu') }
      .to raise_error(ArgumentError, /aria_label/)
  end

  it 'defaults to lg breakpoint' do
    render_inline(described_class.new(hook_class: 'off-canvas-menu', aria_label: 'Navigation'))

    expect(page).to have_css('.lg\\:hidden')
  end

  it 'renders xl breakpoint when specified' do
    render_inline(described_class.new(hook_class: 'off-canvas-menu', aria_label: 'Navigation', breakpoint: :xl))

    expect(page).to have_css('.xl\\:hidden')
  end

  it 'raises ArgumentError for unsupported breakpoints' do
    expect { described_class.new(hook_class: 'off-canvas-menu', aria_label: 'Navigation', breakpoint: :md) }
      .to raise_error(ArgumentError, /Unsupported breakpoint/)
  end

  it 'renders the hook class' do
    render_inline(described_class.new(hook_class: 'lesson-sidebar-drawer', aria_label: 'Course contents'))

    expect(page).to have_css('.lesson-sidebar-drawer')
  end
end
