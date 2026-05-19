require 'rails_helper'

RSpec.describe Lessons::Sidebar::SectionComponent, type: :component do
  it 'renders the section title' do
    section = create(:section, title: 'Getting Started')
    lesson = create(:lesson, section:)
    component = described_class.new(section:, current_lesson: lesson)

    render_inline(component)

    expect(page).to have_content('Getting Started')
  end

  it 'renders one link per lesson in the section' do
    section = create(:section)
    lessons = create_list(:lesson, 3, section:)
    section.reload
    component = described_class.new(section:, current_lesson: lessons.first)

    render_inline(component)

    expect(page).to have_css('li', count: 3)
  end

  context 'when the section contains the current lesson' do
    it 'renders <details> with the open attribute' do
      section = create(:section)
      lesson = create(:lesson, section:)
      component = described_class.new(section:, current_lesson: lesson)

      render_inline(component)

      expect(page).to have_css('details[open]')
    end
  end

  context 'when the section does not contain the current lesson' do
    it 'renders <details> without the open attribute' do
      section = create(:section)
      create(:lesson, section:)
      other_section = create(:section, course: section.course)
      other_lesson = create(:lesson, section: other_section)
      component = described_class.new(section:, current_lesson: other_lesson)

      render_inline(component)

      expect(page).to have_css('details')
      expect(page).to have_no_css('details[open]')
    end
  end
end
