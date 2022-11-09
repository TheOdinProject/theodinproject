class LessonPreviewsRemover
  def call
    expired_lesson_previews.destroy_all
  end

  private

  def expired_lesson_previews
    @expired_lesson_previews ||= LessonPreview.expired
  end
end
