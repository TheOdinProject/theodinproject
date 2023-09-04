require_relative 'redirectors/nested_lesson_redirector'
Rails.application.routes.draw do
  get '/courses/web-development-101(/lessons/:id)', to: redirect('/paths/foundations')
  get '/paths/:path_id/courses/:course_id/lessons/:id', to: redirect(Redirectors::NestedLessonRedirector.new)
  get '/discord', to: redirect(ODIN_CHAT_URL)
  get '/blog', to: redirect(ODIN_BLOG_URL)
end
