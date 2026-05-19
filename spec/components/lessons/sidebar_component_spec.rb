require 'rails_helper'

RSpec.describe Lessons::SidebarComponent, type: :component do
  def setup_course
    path = create(:path)
    course = create(:course, path:)
    section_one = create(:section, course:)
    section_two = create(:section, course:)
    lesson_one = create(:lesson, section: section_one)
    lesson_two = create(:lesson, section: section_two)
    { course:, sections: [section_one, section_two], lesson_one:, lesson_two: }
  end

  it 'renders both the off-canvas drawer and the static desktop aside' do
    data = setup_course
    component = described_class.new(
      course: data[:course],
      sections: data[:sections],
      current_lesson: data[:lesson_one],
    )

    render_inline(component)

    expect(page).to have_css('.lesson-sidebar-drawer')
    expect(page).to have_css('[data-test-id="lesson-sidebar"]')
  end

  it 'renders a details element for each section' do
    data = setup_course
    component = described_class.new(
      course: data[:course],
      sections: data[:sections],
      current_lesson: data[:lesson_one],
    )

    render_inline(component)

    within '[data-test-id="lesson-sidebar"]' do
      expect(page).to have_css('details', count: 2)
    end
  end

  it 'opens only the section that contains the current lesson' do
    data = setup_course
    component = described_class.new(
      course: data[:course],
      sections: data[:sections],
      current_lesson: data[:lesson_two],
    )

    render_inline(component)

    within '[data-test-id="lesson-sidebar"]' do
      expect(page).to have_css('details[open]', count: 1)
    end
  end

  it 'links back to the course via the course title' do
    data = setup_course
    component = described_class.new(
      course: data[:course],
      sections: data[:sections],
      current_lesson: data[:lesson_one],
    )

    render_inline(component)

    within '[data-test-id="lesson-sidebar"]' do
      expect(page).to have_link(data[:course].title)
    end
  end

  context 'when a current_user is given' do
    it 'renders a course-progress bar reflecting their completions' do
      data = setup_course
      user = create(:user)
      create(:lesson_completion, user:, lesson: data[:lesson_one], course: data[:course])
      component = described_class.new(
        course: data[:course],
        sections: data[:sections],
        current_lesson: data[:lesson_one],
        current_user: user,
      )

      render_inline(component)

      within '[data-test-id="lesson-sidebar"]' do
        expect(page).to have_css('[role="progressbar"][aria-valuenow="50"]')
        expect(page).to have_text('50% complete')
      end
    end
  end

  context 'when no current_user is given' do
    it 'does not render a progress bar' do
      data = setup_course
      component = described_class.new(
        course: data[:course],
        sections: data[:sections],
        current_lesson: data[:lesson_one],
      )

      render_inline(component)

      expect(page).to have_no_css('[role="progressbar"]')
    end
  end
end
