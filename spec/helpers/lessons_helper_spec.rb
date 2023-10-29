require 'rails_helper'

RSpec.describe LessonsHelper do
  describe '#github_edit_url' do
    let(:lesson) { create(:lesson) }

    it 'returns the github edit url for the lesson' do
      expect(helper.github_edit_url(lesson)).to eql(
        'https://github.com/TheOdinProject/curriculum/edit/main/lesson_course/lesson_title.md'
      )
    end
  end

  describe '#github_report_url' do
    let(:lesson) { create(:lesson, title: 'Ruby Basics') }

    it 'returns the correct github url' do
      expect(helper.github_report_url(lesson)).to eql(
        'https://github.com/TheOdinProject/curriculum/issues/new?labels=Status%3A+Needs+Triage&lesson-link=http%3A%2F%2Ftest.host%2Flessons%2Ftest-course1-ruby-basics&template=suggestion.yaml&title=Ruby+Basics%3A+%3CShort+description+of+your+suggestion%3E'
      )
    end
  end
end
