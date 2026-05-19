require 'rails_helper'

RSpec.describe 'Lesson show sidebar' do
  let(:user) { create(:user) }
  let(:course) { create(:course, path: create(:path, default_path: true)) }

  def build_curriculum(course)
    section_one = create(:section, position: 1, course:, title: 'Getting Started')
    section_two = create(:section, position: 2, course:, title: 'Advanced Topics')
    {
      current: create(:lesson, position: 1, section: section_one, title: 'Intro'),
      sibling: create(:lesson, position: 2, section: section_one, title: 'Next Steps'),
      other: create(:lesson, position: 1, section: section_two, title: 'Deep Dive')
    }
  end

  before do
    sign_in(user)
    page.driver.resize(1400, 900)
  end

  it 'keeps manually expanded sections open after navigating' do
    lessons = build_curriculum(course)

    visit lesson_path(lessons[:current])

    within('[data-test-id="lesson-sidebar"]') do
      find('summary', text: 'Advanced Topics').click
      click_link lessons[:other].title
    end

    within('[data-test-id="lesson-sidebar"]') do
      expect(page).to have_css('details[open]', text: 'Advanced Topics')
      expect(page).to have_css('details[open]', text: 'Getting Started')
      expect(page).to have_css('a[aria-current="page"]', text: 'Deep Dive')
    end
  end
end
