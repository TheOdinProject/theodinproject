require './lib/seeds/lesson_builder'
require 'rails_helper'

RSpec.describe Seeds::LessonBuilder do
  subject(:lesson_builder) { described_class.build(section, position, attributes) }

  let(:section) { create(:section, course:) }
  let(:course) { create(:course) }
  let(:position) { 1 }
  let(:attributes) do
    {
      title: 'Ruby Lesson',
      identifier_uuid: 'lesson_uuid',
      description: 'lesson description',
      github_path: '/github/lesson_path',
      is_project: true,
      accepts_submission: true,
      previewable: true,
    }
  end

  describe '.build' do
    it 'builds a new lesson' do
      expect { lesson_builder }.to change { Lesson.count }.from(0).to(1)
    end

    it 'builds a lesson with the given title' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.title).to eq('Ruby Lesson')
    end

    it 'builds a lesson with the given description' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.description).to eq('lesson description')
    end

    it 'builds a lesson with the given position' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.position).to eq(1)
    end

    it 'builds a lesson with a true is_project attribute' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.is_project).to be(true)
    end

    it 'builds a lesson with a true accepts_submission attribute' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.accepts_submission).to be(true)
    end

    it 'builds a lesson with a true previewable attribute' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.previewable).to be(true)
    end

    context 'when optional attributes are not present' do
      let(:attributes) do
        {
          title: 'Ruby Lesson',
          identifier_uuid: 'lesson_uuid',
          description: 'lesson description',
          github_path: '/github/lesson_path',
        }
      end

      it 'builds a lesson with a false is_project attribute' do
        lesson_builder

        lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
        expect(lesson.is_project).to be(false)
      end

      it 'builds a lesson with a false accepts_submission attribute' do
        lesson_builder

        lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
        expect(lesson.accepts_submission).to be(false)
      end

      it 'builds a lesson with a false previewable attribute' do
        lesson_builder

        lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
        expect(lesson.previewable).to be(false)
      end
    end

    it 'builds a lesson with the given url' do
      lesson_builder

      lesson = Lesson.find_by(identifier_uuid: 'lesson_uuid')
      expect(lesson.github_path).to eq('/github/lesson_path')
    end

    context 'when the lesson already exists' do
      it 'updates the attributes that are different' do
        existing_lesson = create(
          :lesson,
          identifier_uuid: 'lesson_uuid',
          title: 'JS Lesson',
          position: 2,
          section:,
          course_id: course.id,
        )

        expect { lesson_builder }.to change { existing_lesson.reload.title }
          .from('JS Lesson').to('Ruby Lesson')
          .and change { existing_lesson.position }.from(2).to(1)
      end
    end
  end
end
