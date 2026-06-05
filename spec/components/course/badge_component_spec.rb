require 'rails_helper'

RSpec.describe Course::BadgeComponent, type: :component do
  include Rails.application.routes.url_helpers

  context 'when the user is signed in' do
    it 'renders the loading progress circle' do
      course = create(:course)
      user = create(:user)
      component = described_class.new(course:)

      sign_in(user)
      render_inline(component)

      expect(page).to have_css("[data-test-id='loading-progress-circle']")
    end
  end

  context 'when the user is not signed in' do
    it 'renders the course badge' do
      course = create(:course)
      component = described_class.new(course:)

      render_inline(component)

      expect(page).to have_css("[data-test-id='default-badge']")
    end
  end

  context 'when linked is true' do
    it 'renders a link to the course badge' do
      course = create(:course)
      component = described_class.new(course:, linked: true)

      render_inline(component)

      expect(page).to have_link(href: path_course_path(course.path, course))
    end
  end

  context 'when linked is false' do
    it 'does not render a link to the course badge' do
      course = create(:course)
      component = described_class.new(course:, linked: false)

      render_inline(component)

      expect(page).to have_no_link(href: path_course_path(course.path, course))
    end
  end
end
