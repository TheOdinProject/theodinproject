class LessonPreviewsRemover
  def call
    more_than_one_month_lesson_previews_old.destroy_all
  end

  private

  def more_than_one_month_lesson_previews_old
    @more_than_one_month_lesson_previews_old ||=
      LessonPreview.where(created_at: ..1.month.ago.end_of_day)
  end
end
