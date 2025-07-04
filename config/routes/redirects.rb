require_relative 'redirectors/nested_lesson_redirector'
Rails.application.routes.draw do
  get '/courses/web-development-101(/lessons/:id)', to: redirect('/paths/foundations')
  get '/paths/:path_id/courses/:course_id/lessons/:id', to: redirect(Redirectors::NestedLessonRedirector.new)
  get '/discord', to: redirect(DATAMONK_CHAT_URL)
  get '/blog', to: redirect(DATAMONK_BLOG_URL), as: :blog
end
