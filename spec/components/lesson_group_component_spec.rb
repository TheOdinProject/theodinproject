require 'rails_helper'

RSpec.describe LessonGroupComponent, type: :component do
  it 'renders the list with a title' do
    component = described_class.new(title: 'HTML Basics', lessons: [])

    render_inline(component)

    expect(page).to have_css('h3', text: 'HTML Basics')
  end

  it 'renders the list of lessons' do
    count = rand(10)
    component = described_class.new(
      title: 'HTML Basics',
      lessons: create_list(:lesson, count, title: 'Lesson title'),
    )

    render_inline(component)

    expect(page).to have_content('Lesson title', count:)
  end
end
