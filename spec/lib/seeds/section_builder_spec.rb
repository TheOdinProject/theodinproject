require './lib/seeds/section_builder'
require 'rails_helper'

RSpec.describe Seeds::SectionBuilder do
  subject(:section_builder) do
    described_class.build(course, position) do |section|
      section.identifier_uuid = 'section_uuid'
      section.title = 'Basics Section'
      section.description = 'a basics section'
    end
  end

  let(:course) { create(:course) }
  let(:position) { 1 }

  describe '.build' do
    it 'builds a new section' do
      expect { section_builder }.to change { Section.count }.from(0).to(1)
    end

    it 'builds a section with the given title' do
      section_builder

      section = Section.find_by(identifier_uuid: 'section_uuid')
      expect(section.title).to eq('Basics Section')
    end

    it 'builds a section with the given description' do
      section_builder

      section = Section.find_by(identifier_uuid: 'section_uuid')
      expect(section.description).to eq('a basics section')
    end

    it 'builds a section with the given position' do
      section_builder

      section = Section.find_by(identifier_uuid: 'section_uuid')
      expect(section.position).to eq(1)
    end

    context 'when the section already exists' do
      it 'updates the attributes that are different' do
        existing_section = create(
          :section,
          identifier_uuid: 'section_uuid',
          title: 'Intermediate Section',
          position: 2,
          course:
        )

        expect { section_builder }.to change { existing_section.reload.title }
          .from('Intermediate Section').to('Basics Section')
          .and change { existing_section.position }.from(2).to(1)
      end
    end
  end

  describe '#add_lessons' do
    let(:section) { Section.find_by(identifier_uuid: 'section_uuid') }

    it 'adds lessons to the section' do
      section_builder

      expect do
        section_builder.add_lessons(
          {
            title: 'Ruby Lesson',
            description: 'A Ruby Lesson',
            identifier_uuid: 'lesson_uuid_1',
            github_path: '/github/url',
          },
          {
            title: 'JS Lesson',
            description: 'A JS Lesson',
            identifier_uuid: 'lesson_uuid_2',
            github_path: '/github/url',
          }
        )
      end.to change { course.lessons.count }.from(0).to(2)
    end

    context 'when adding multiple lessons' do
      it 'applies to correct position to each lesson' do
        lessons = section_builder.add_lessons(
          {
            title: 'Ruby Lesson',
            description: 'A Ruby Lesson',
            identifier_uuid: 'lesson_uuid_1',
            github_path: '/github/url_ruby',
          },
          {
            title: 'JS Lesson',
            description: 'A JS Lesson',
            identifier_uuid: 'lesson_uuid_2',
            github_path: '/github/url_js',
          },
          {
            title: 'HTML and CSS Lesson',
            description: 'A HTML and CSS Lesson',
            identifier_uuid: 'lesson_uuid_3',
            github_path: '/github/url_html',
          }
        ).flatten

        expect(lessons.first.position).to eq(1)
        expect(lessons.second.position).to eq(2)
        expect(lessons.third.position).to eq(3)
      end
    end
  end
end
