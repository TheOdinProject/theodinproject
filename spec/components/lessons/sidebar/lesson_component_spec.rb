require 'rails_helper'

RSpec.describe Lessons::Sidebar::LessonComponent, type: :component do
  it 'renders the lesson title as a link' do
    lesson = create(:lesson, title: 'HTML Basics')
    component = described_class.new(lesson:, current_lesson: lesson)

    render_inline(component)

    expect(page).to have_link('HTML Basics', href: "/lessons/#{lesson.friendly_id}")
  end

  context 'when rendered as the current lesson' do
    it 'marks the link with aria-current="page"' do
      lesson = create(:lesson)
      component = described_class.new(lesson:, current_lesson: lesson)

      render_inline(component)

      expect(page).to have_css('a[aria-current="page"]')
    end
  end

  context 'when rendered as a sibling lesson' do
    it 'does not set aria-current' do
      lesson = create(:lesson)
      other = create(:lesson, section: lesson.section)
      component = described_class.new(lesson:, current_lesson: other)

      render_inline(component)

      expect(page).to have_no_css('a[aria-current]')
    end
  end

  context 'when a current_user is given' do
    it 'renders a completion icon' do
      lesson = create(:lesson)
      user = create(:user)
      component = described_class.new(lesson:, current_lesson: lesson, current_user: user)

      render_inline(component)

      expect(page).to have_css('[data-test-id="lesson-sidebar-completion"]')
    end
  end

  context 'when no current_user is given' do
    it 'does not render the completion icon' do
      lesson = create(:lesson)
      component = described_class.new(lesson:, current_lesson: lesson)

      render_inline(component)

      expect(page).to have_no_css('[data-test-id="lesson-sidebar-completion"]')
    end
  end
end
