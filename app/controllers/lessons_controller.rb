class LessonsController < ApplicationController
  before_action :set_cache_control_header_to_no_store

  def show
    @lesson = Lesson.find(params[:id])

    if user_signed_in?
      mark_completed
      @project_submissions = public_project_submissions
      @user_submission = current_user_submission
    end
  end

  private

  def public_project_submissions
    project_submissions_query.public_submissions.map do |submission|
      ProjectSubmissionSerializer.as_json(submission, current_user) if submission.present?
    end
  end

  def current_user_submission
    submission = project_submissions_query.current_user_submission

    ProjectSubmissionSerializer.as_json(submission, current_user) if submission.present?
  end

  def project_submissions_query
    ::LessonProjectSubmissionsQuery.new(lesson: @lesson, current_user:, limit: 10)
  end

  def mark_completed
    Courses::MarkCompletedLessons.call(
      user: current_user,
      lessons: Array(@lesson)
    )
  end
end
