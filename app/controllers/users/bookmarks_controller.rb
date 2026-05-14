class Users::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: %i[create destroy]

  def index
    @bookmarks = current_user.bookmarks
    @lessons = current_user.bookmarked_lessons
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    respond_to do |format|
      @bookmark = current_user.bookmarks.build(lesson: @lesson)

      if @bookmark.save
        format.turbo_stream { flash.now[:notice] = create_or_destroy_bookmark_helper }
        format.html { redirect_to({ action: 'index' }, notice: create_or_destroy_bookmark_helper) }
      else
        format.html { redirect_back status: :unprocessable_entity, alert: 'Unable to create bookmark' }
      end
    end
  end

  def destroy
    respond_to do |format|
      @bookmark = Bookmark.find(params[:id])
      @bookmark.destroy

      format.turbo_stream { flash.now[:notice] = create_or_destroy_bookmark_helper(destroy: true) }
      format.html { redirect_to({ action: 'index' }, notice: create_or_destroy_bookmark_helper(destroy: true)) }
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  # HACK: Temp method for easier prototyping
  def create_or_destroy_bookmark_helper(destroy: false)
    <<~FLASH.html_safe # rubocop:disable Rails/OutputSafety
      Bookmark #{destroy ? 'removed' : 'created'}!
      #{helpers.link_to 'Click to see saved bookmarks', users_bookmarks_path}
    FLASH
  end
end
