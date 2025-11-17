require 'rails_helper'

RSpec.describe LessonListComponent, type: :component do
  it 'renders the list with a title' do
    component = described_class.new(title: 'HTML Basics', lessons: [], current_user: nil)

    render_inline(component)

    expect(page).to have_css('h3', text: 'HTML Basics')
  end

  it 'renders the list of lessons' do
    component = described_class.new(title: 'HTML Basics', lessons: [], current_user: nil)

    render_inline(component)

    expect(page).to have_css('div[data-test-id="lesson-list"]')
  end
end
