module ApplicationHelper
  require 'kramdown'
  include Pagy::Frontend

  def github_link(extension = '')
    "https://github.com/TheOdinProject/#{extension}"
  end

  def title(input = nil)
    content_for(:title) { "#{input} | The Odin Project" } if input
  end

  def sign_up_or_view_curriculum_button
    if current_user
      curriculum_button
    else
      sign_up_button
    end
  end

  def percentage_completed_by_user(course, user)
    user.progress_for(course).percentage
  end

  def course_completed_by_user?(course, user)
    user.progress_for(course).completed?
  end

  def next_lesson_to_complete(course, completed_lessons)
    NextLesson.new(course, completed_lessons).to_complete
  end

  def unread_notifications?(user)
    user.notifications.any?(&:unread?)
  end
end
