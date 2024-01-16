class Bookmarks::ButtonComponent < ApplicationComponent
  def initialize(lesson:, bookmark:, current_user: nil)
    @lesson = lesson
    @current_user = current_user
    @bookmark = bookmark
  end

  private

  attr_reader :lesson, :current_user, :bookmark

  def render?
    return false unless current_user

    Feature.enabled?(:bookmarks, current_user)
  end

  def bookmarked?
    bookmark.present?
  end

  def icon
    bookmarked? ? 'fa-solid fa-bookmark' : 'fa-regular fa-bookmark'
  end

  def create_or_destroy_path
    bookmarked? ? users_bookmark_path(bookmark) : users_bookmarks_path
  end
end
