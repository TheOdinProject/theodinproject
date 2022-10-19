require './lib/seeds/path_builder'
require 'rails_helper'

RSpec.describe Seeds::PathBuilder do
  subject(:path_builder) do
    described_class.build do |path|
      path.identifier_uuid = 'path_uuid'
      path.title = 'Foundations'
      path.description = 'a foundation path'
      path.position = 1
      path.default_path = true
      path.badge_uri = 'foundations_path_badge.svg'
    end
  end

  describe '.build' do
    it 'builds a new path' do
      expect { path_builder }.to change { Path.count }.from(0).to(1)
    end

    it 'builds a path with the given title' do
      path_builder

      path = Path.find_by(identifier_uuid: 'path_uuid')
      expect(path.title).to eq('Foundations')
    end

    it 'builds a path with the given description' do
      path_builder

      path = Path.find_by(identifier_uuid: 'path_uuid')
      expect(path.description).to eq('a foundation path')
    end

    it 'builds a path with the given position' do
      path_builder

      path = Path.find_by(identifier_uuid: 'path_uuid')
      expect(path.position).to eq(1)
    end

    it 'builds a path with the given default path attribute' do
      path_builder

      path = Path.find_by(identifier_uuid: 'path_uuid')
      expect(path.default_path).to be(true)
    end

    context 'when the path already exists' do
      it 'updates the attributes that are different' do
        existing_path = create(:path, identifier_uuid: 'path_uuid', title: 'Development 101', position: 2)

        expect { path_builder }.to change { existing_path.reload.title }
          .from('Development 101').to('Foundations')
          .and change { existing_path.position }.from(2).to(1)
      end
    end
  end

  describe '#add_course' do
    let(:path) { Path.find_by(identifier_uuid: 'path_uuid') }

    it 'adds a course to the path' do
      path_builder

      expect do
        path_builder.add_course do |course|
          course.identifier_uuid = 'course_uuid'
          course.title = 'Ruby'
          course.description = 'A Ruby course'
          course.badge_uri = 'ruby-soho.jpeg'
        end
      end.to change { path.courses.count }.from(0).to(1)
    end

    context 'when adding multiple courses' do
      it 'applies to correct position to each course' do
        course_one = path_builder.add_course do |course|
          course.identifier_uuid = 'course_uuid_1'
          course.title = 'Ruby'
          course.description = 'A Ruby course'
          course.badge_uri = 'ruby-soho.jpeg'
        end

        course_two = path_builder.add_course do |course|
          course.identifier_uuid = 'course_uuid_2'
          course.title = 'Rails'
          course.description = 'A Rails course'
          course.badge_uri = 'choo-choo-choose-you.bmp'
        end

        course_three = path_builder.add_course do |course|
          course.identifier_uuid = 'course_uuid_3'
          course.title = 'JS'
          course.description = 'A JS course'
          course.badge_uri = 'jolly-smith.jpg'
        end

        expect(course_one.course.position).to eq(1)
        expect(course_two.course.position).to eq(2)
        expect(course_three.course.position).to eq(3)
      end
    end
  end

  describe '#delete_removed_courses' do
    it 'deletes courses that are in the db but removed from the seeds file' do
      path = create(:path, identifier_uuid: 'path_uuid')
      create(:course, identifier_uuid: 'course_uuid_1', path_id: path.id)
      seeded_course = create(:course, identifier_uuid: 'course_uuid_2', path_id: path.id)

      path_builder.add_course do |course|
        course.identifier_uuid = 'course_uuid_2'
        course.badge_uri = 'nothing-to-see-here.svg'
      end

      path_builder.delete_removed_courses
      expect(path_builder.path.courses.reload).to contain_exactly(seeded_course)
    end
  end
end
