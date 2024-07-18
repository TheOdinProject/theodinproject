require 'rails_helper'

RSpec.describe Reports::PathLessonCompletionsDayStat do
  it { is_expected.to belong_to(:path) }
  it { is_expected.to belong_to(:course) }

  describe '.for_date_range' do
    it 'returns path lesson completion stats for the given date range' do
      course = create(:course)
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 1))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 2))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 3))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 4))

      described_class.refresh

      expect(described_class.for_date_range('2022-01-01', '2022-01-02').map(&:date))
        .to contain_exactly(Time.utc(2022, 1, 1), Time.utc(2022, 1, 2))
    end
  end

  describe '.group_by_lesson' do
    it 'returns path lesson completion stats grouped by lesson' do
      course = create(:course)
      lesson_one = create(:lesson, title: 'Ruby basics', course:, position: 1)
      lesson_two = create(:lesson, title: 'JS basics', course:, position: 2)

      create(:lesson_completion, course:, lesson: lesson_one, created_at: Time.utc(2022, 1, 1))
      create(:lesson_completion, course:, lesson: lesson_two, created_at: Time.utc(2022, 2, 2))
      create(:lesson_completion, course:, lesson: lesson_one, created_at: Time.utc(2022, 1, 4))

      described_class.refresh

      expect(described_class.group_by_lesson).to contain_exactly(
        have_attributes(lesson_title: 'Ruby basics', count: 2), have_attributes(lesson_title: 'JS basics', count: 1)
      )
    end

    it 'orders the stats by course position first and then lesson position' do
      path = create(:path)
      first_course = create(:course, position: 1)
      second_course = create(:course, position: 2)
      lesson_one = create(:lesson, title: 'Ruby basics', position: 1)
      lesson_two = create(:lesson, title: 'JS basics', position: 2)
      lesson_three = create(:lesson, title: 'HTML basics', position: 10)

      create(:lesson_completion, path:, course: first_course, lesson: lesson_two, created_at: Time.utc(2022, 1, 4))
      create(:lesson_completion, path:, course: first_course, lesson: lesson_three, created_at: Time.utc(2022, 1, 4))
      create(:lesson_completion, path:, course: second_course, lesson: lesson_one, created_at: Time.utc(2022, 1, 1))
      create(:lesson_completion, path:, course: second_course, lesson: lesson_one, created_at: Time.utc(2022, 2, 2))

      described_class.refresh

      expect(described_class.group_by_lesson.map(&:lesson_title)).to eq(['JS basics', 'HTML basics', 'Ruby basics'])
    end
  end

  describe '.filter_by_course' do
    it 'returns all lesson completion stats for the given course' do
      course = create(:course)
      create(:lesson_completion, created_at: Time.utc(2022, 1, 1))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 2))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 3))
      create(:lesson_completion, created_at: Time.utc(2022, 1, 4))

      described_class.refresh

      expect(described_class.filter_by_course(nil).map(&:date)).to eq(
        [Time.utc(2022, 1, 3), Time.utc(2022, 1, 2)]
      )
    end

    context 'when course_id is blank' do
      it 'returns all lesson completion stats' do
        course = create(:course)
        create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 1))
        create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 2))
        create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 3))
        create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 4))

        described_class.refresh

        expect(described_class.filter_by_course(nil).map(&:date)).to eq(
          [Time.utc(2022, 1, 4), Time.utc(2022, 1, 3), Time.utc(2022, 1, 2), Time.utc(2022, 1, 1)]
        )
      end
    end
  end

  describe '.earliest_date' do
    it 'returns the earliest path lesson completions stat' do
      course = create(:course)
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 1))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 2, 1))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 3, 1))

      described_class.refresh

      expect(described_class.earliest_date).to eq(Time.utc(2022, 1, 1))
    end

    context 'when there are no lesson completions' do
      it 'defaults to today' do
        described_class.refresh
        expect(described_class.earliest_date).to eq(Time.zone.today)
      end
    end
  end

  describe '.latest_date' do
    it 'returns the earliest path lesson completions stat' do
      course = create(:course)
      create(:lesson_completion, course:, created_at: Time.utc(2022, 1, 1))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 2, 1))
      create(:lesson_completion, course:, created_at: Time.utc(2022, 3, 1))

      described_class.refresh

      expect(described_class.latest_date).to eq(Time.utc(2022, 3, 1))
    end

    context 'when there are no lesson completions' do
      it 'defaults to today' do
        described_class.refresh
        expect(described_class.latest_date).to eq(Time.zone.today)
      end
    end
  end
end
