class LessonProjectSubmissionsQuery
  def initialize(lesson, limit: nil)
    @lesson = lesson
    @limit = limit
  end

  def with_current_user_submission_first(user)
    lesson_project_submissions
  end

  private

  attr_reader :lesson, :limit

  def lesson_project_submissions
    lesson.project_submissions.viewable.order(cached_votes_total: :desc, created_at: :desc).limit(limit)
  end
end
