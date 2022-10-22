require 'rails_helper'

RSpec.describe Sections::LessonComponent, type: :component do
  context 'when a project' do
    it 'returns the project title' do
      lesson = create(:lesson, is_project: true, title: 'HTML Basics')
      component = described_class.new(lesson:, current_user: nil)

      render_inline(component)

      expect(page).to have_content('Project: HTML Basics')
    end
  end

  context 'when a lesson' do
    it 'returns the lesson title' do
      lesson = create(:lesson, is_project: false, title: 'HTML Basics')
      component = described_class.new(lesson:, current_user: nil)

      render_inline(component)

      expect(page).to have_content('HTML Basics')
    end
  end
end
