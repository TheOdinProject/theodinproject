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
      expect(helper.github_report_url(lesson, '/lessons/ruby-basics')).to eql(
        # rubocop:disable Layout/LineLength
        'https://github.com/TheOdinProject/curriculum/issues/new?assignees=nil&labels=Status%3A+Needs+Triage&projects=&template=suggestion.yaml&title=Ruby Basics%3A+%3CShort+description+of+your+suggestion%3E&lesson-link=https://www.theodinproject.com/lessons/ruby-basics'
        # rubocop:enable Layout/LineLength
      )
    end
  end
end
