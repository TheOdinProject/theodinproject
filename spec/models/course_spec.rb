require 'rails_helper'

RSpec.describe Course do
  subject(:course) { described_class.new }

  it { is_expected.to belong_to(:path) }
  it { is_expected.to have_many(:sections).order(:position) }
  it { is_expected.to have_many(:lessons).through(:sections) }

  it { is_expected.to validate_presence_of(:position) }

  describe '.badges' do
    it 'only displays homepage badges' do
      create_list(:course, 2)
      course_three = create(:course, show_on_homepage: true)

      expect(described_class.badges).to contain_exactly(course_three)
    end
  end

  describe '#progress_for' do
    let(:course) { build_stubbed(:course) }
    let(:user) { build_stubbed(:user) }

    before do
      allow(user).to receive(:progress_for)
    end

    it 'returns the users progress for the course' do
      course.progress_for(user)
      expect(user).to have_received(:progress_for).with(course)
    end
  end

  describe '#next_lesson' do
    context 'when there is a next lesson' do
      it 'returns the next lesson' do
        course = create(:course)
        section = create(:section, course:)
        next_lesson = create(:lesson, position: 3, section:)
        current_lesson = create(:lesson, position: 2, section:)
        _previous_lesson = create(:lesson, position: 1, section:)

        expect(course.next_lesson(current_lesson)).to eql(next_lesson)
      end
    end

    context 'when the next lesson is in a later section' do
      it 'returns the lowest-position lesson after the current one' do
        course = create(:course)
        section = create(:section, position: 1, course:)
        next_section = create(:section, position: 2, course:)
        current_lesson = create(:lesson, position: 1, section:)
        first_lesson_in_next_section = create(:lesson, position: 2, section: next_section)
        _second_lesson_in_next_section = create(:lesson, position: 3, section: next_section)

        expect(course.next_lesson(current_lesson)).to eql(first_lesson_in_next_section)
      end
    end

    context 'when there is no next lesson' do
      it 'returns nothing' do
        course = create(:course)
        section = create(:section, course:)
        current_lesson = create(:lesson, position: 1, section:)

        expect(course.next_lesson(current_lesson)).to be_nil
      end
    end
  end

  describe '#previous_lesson' do
    context 'when there is a previous lesson' do
      it 'returns the previous lesson' do
        course = create(:course)
        section = create(:section, course:)
        current_lesson = create(:lesson, position: 2, section:)
        previous_lesson = create(:lesson, position: 1, section:)
        _next_lesson = create(:lesson, position: 3, section:)

        expect(course.previous_lesson(current_lesson)).to eql(previous_lesson)
      end
    end

    context 'when the previous lesson is in an earlier section' do
      it 'returns the highest-position lesson before the current one' do
        course = create(:course)
        section = create(:section, position: 1, course:)
        next_section = create(:section, position: 2, course:)
        _first_lesson_in_previous_section = create(:lesson, position: 1, section:)
        last_lesson_in_previous_section = create(:lesson, position: 2, section:)
        current_lesson = create(:lesson, position: 3, section: next_section)

        expect(course.previous_lesson(current_lesson)).to eql(last_lesson_in_previous_section)
      end
    end

    context 'when there is no previous lesson' do
      it 'returns nothing' do
        course = create(:course)
        section = create(:section, course:)
        current_lesson = create(:lesson, position: 1, section:)

        expect(course.previous_lesson(current_lesson)).to be_nil
      end
    end
  end
end
