require 'rails_helper'

RSpec.describe Lesson do
  subject(:lesson) { create(:lesson) }

  it { is_expected.to belong_to(:section) }
  it { is_expected.to have_one(:course).through(:section) }
  it { is_expected.to have_one(:content) }
  it { is_expected.to have_many(:project_submissions) }
  it { is_expected.to have_many(:lesson_completions) }
  it { is_expected.to have_many(:completing_users).through(:lesson_completions) }

  it { is_expected.to validate_presence_of(:position) }

  describe '.most_recent_updated_at' do
    before do
      travel_to Time.utc(2021, 4, 14)
    end

    after do
      travel_back
    end

    it 'returns the most recently updated_at time stamp' do
      create(:lesson, updated_at: 2.weeks.ago)
      create(:lesson, updated_at: 1.week.ago)
      create(:lesson, updated_at: Time.utc(2021, 4, 10, 15))

      expect(described_class.most_recent_updated_at).to eql(Time.utc(2021, 4, 10, 15))
    end
  end

  describe '.installation_lessons' do
    it 'returns all the installation lessons' do
      installation_lesson_one = create(:lesson, installation_lesson: true)
      installation_lesson_two = create(:lesson, installation_lesson: true)
      create(:lesson, installation_lesson: false)

      expect(described_class.installation_lessons).to contain_exactly(
        installation_lesson_one, installation_lesson_two
      )
    end
  end

  describe 'slug' do
    it 'returns the course and lesson title as the slug' do
      course = create(:course, title: 'course title')
      lesson = create(:lesson, title: 'lesson title', course:)

      expect(lesson.slug).to eql('course-title-lesson-title')
    end

    context 'when lesson is shared across paths' do
      it 'returns the path, course and lesson title as the slug' do
        path = create(:path, short_title: 'path title')
        course = create(:course, title: 'course title', path:)
        create(:lesson, title: 'lesson title', course:)
        shared_lesson = create(:lesson, title: 'lesson title', course:)

        expect(shared_lesson.slug).to eql('path-title-course-title-lesson-title')
      end
    end

    context 'when path and course title are the same' do
      it 'returns the just the course and lesson title as the slug' do
        path = create(:path, short_title: 'foundations')
        course = create(:course, title: 'foundations', path:)
        lesson = create(:lesson, title: 'lesson title', course:)

        expect(lesson.slug).to eql('foundations-lesson-title')
      end
    end

    context 'when course and lesson title are the same' do
      it 'returns the just the course and lesson title as the slug' do
        path = create(:path, short_title: 'path title')
        course = create(:course, title: 'databases', path:)
        lesson = create(:lesson, title: 'databases', course:)

        expect(lesson.slug).to eql('databases')
      end
    end

    context 'when three or more lessons share the same slug candidates' do
      before do
        allow(SecureRandom).to receive(:hex).with(2).and_return('1234')
      end

      it 'returns default slug candidate post fixed with the random hex' do
        path = create(:path, short_title: 'path title')
        course = create(:course, title: 'course title', path:)
        create(:lesson, title: 'lesson title', course:)
        create(:lesson, title: 'lesson title', course:)
        lesson_three = create(:lesson, title: 'lesson title', course:)

        expect(lesson_three.slug).to eql('path-title-course-title-lesson-title-1234')
      end
    end
  end

  describe '#completed' do
    it 'return false by default' do
      expect(lesson.completed).to be(false)
    end

    context 'when the lesson has been completed' do
      it 'returns true' do
        lesson.completed = true
        expect(lesson).to be_completed
      end
    end

    context 'when the lesson has been not been completed' do
      it 'returns false' do
        lesson.completed = false
        expect(lesson).not_to be_completed
      end
    end
  end

  describe '#recently_added?' do
    context 'when the lesson was added today' do
      it 'returns true' do
        lesson = create(:lesson, created_at: Time.zone.today)
        expect(lesson.recently_added?).to be(true)
      end
    end

    context 'when the lesson was added within last 2 weeks' do
      it 'returns true' do
        lesson = create(:lesson, created_at: 2.weeks.ago)
        expect(lesson.recently_added?).to be(true)
      end
    end

    context 'when the lesson was added more than 2 weeks ago' do
      it 'returns false' do
        lesson = create(:lesson, created_at: 2.weeks.ago - 1.day)
        expect(lesson.recently_added?).to be(false)
      end
    end
  end

  describe '#complete!' do
    it 'marks the lesson as completed' do
      expect { lesson.complete! }.to change { lesson.completed }.from(false).to(true)
    end
  end

  describe '#incomplete!' do
    it 'marks the lesson as incomplete' do
      lesson.completed = true
      expect { lesson.incomplete! }.to change { lesson.completed }.from(true).to(false)
    end
  end

  describe '#import_content_from_github' do
    it 'uses the lesson content importer to get lesson content from github' do
      allow(Github::LessonContentImporter).to receive(:for)

      lesson.import_content_from_github

      expect(Github::LessonContentImporter).to have_received(:for).with(lesson)
    end
  end

  describe '#display_title' do
    context 'when lesson is a project' do
      it 'returns the project title' do
        lesson = build_stubbed(:lesson, is_project: true, title: 'Ruby Basics')

        expect(lesson.display_title).to eql('Project: Ruby Basics')
      end
    end

    context 'when lesson is not a project' do
      it 'returns the normal lesson title' do
        lesson = build_stubbed(:lesson, is_project: false, title: 'Ruby Basics')

        expect(lesson.display_title).to eql('Ruby Basics')
      end
    end
  end
end
