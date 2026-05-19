require 'rails_helper'

RSpec.describe Lessons::Sidebar::CompletionIconComponent, type: :component do
  context 'when the lesson is completed' do
    it 'fills the icon with the completed color' do
      lesson = create(:lesson)
      lesson.completed = true

      render_inline(described_class.new(lesson:))

      expect(page).to have_css('[data-test-id="lesson-sidebar-completion"].text-teal-600')
    end

    it 'labels the icon "Lesson completed"' do
      lesson = create(:lesson)
      lesson.completed = true

      render_inline(described_class.new(lesson:))

      expect(page).to have_css('svg title', text: 'Lesson completed', visible: :all)
    end
  end

  context 'when the lesson is incomplete' do
    it 'fills the icon with the incomplete color' do
      lesson = create(:lesson)

      render_inline(described_class.new(lesson:))

      expect(page).to have_css('[data-test-id="lesson-sidebar-completion"].text-gray-300')
    end

    it 'labels the icon "Lesson not completed"' do
      lesson = create(:lesson)

      render_inline(described_class.new(lesson:))

      expect(page).to have_css('svg title', text: 'Lesson not completed', visible: :all)
    end
  end
end
