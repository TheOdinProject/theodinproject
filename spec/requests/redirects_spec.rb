require 'rails_helper'

RSpec.describe 'Redirects' do
  context 'when a request is made to web development 101 paths' do
    it 'redirects the old web development 101 course path to the foundations path' do
      get '/courses/web-development-101'
      expect(response).to redirect_to('/paths/foundations')
    end

    it 'redirects the old web development 101 lesson paths to the foundations path' do
      get '/courses/web-development-101/lessons/a-lesson'
      expect(response).to redirect_to('/paths/foundations')
    end
  end

  describe 'when a request is made to a nested path lesson' do
    it 'redirects the deeply nested path lesson to a unnested lesson' do
      course = create(:course, title: 'test course')
      create(:lesson, course:, title: 'test lesson')

      get '/paths/a-path/courses/test-course/lessons/test-course-test-lesson'

      expect(response).to redirect_to('/lessons/test-course-test-lesson')
      expect(response).to have_http_status(:moved_permanently)
    end

    context "when the course doesn't exist" do
      it 'redirects to paths' do
        get '/paths/a-path/courses/test-course/lessons/test-course-test-lesson'

        expect(response).to redirect_to('/paths')
        expect(response).to have_http_status(:moved_permanently)
      end
    end

    context "when the course lesson doesn't exist" do
      it 'redirects to paths' do
        create(:course, title: 'test course')

        get '/paths/a-path/courses/test-course/lessons/test-course-test-lesson'

        expect(response).to redirect_to('/paths')
        expect(response).to have_http_status(:moved_permanently)
      end
    end
  end

  describe 'GET #discord' do
    it 'redirects to the discord invite link' do
      get '/discord'
      expect(response).to redirect_to(DATAMONK_CHAT_URL)
    end
  end

  describe 'GET /blog' do
    it 'redirects to the blog page' do
      get '/blog'
      expect(response).to redirect_to(DATAMONK_BLOG_URL)
    end
  end
end
