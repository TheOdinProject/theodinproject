require 'rails_helper'

RSpec.describe 'Lesson', type: :request do
  describe 'GET #show' do
    context 'when path_id and course_id params are present' do
      it 'finds the lesson using the path and course params' do
        lesson = create(:lesson)

        get path_course_lesson_path(lesson.path, lesson.course, lesson)

        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end

    context 'when path_id and course_id params are not present' do
      it 'finds the lesson using the id param' do
        lesson = create(:lesson)

        get lesson_path(lesson)

        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end
  end
end
