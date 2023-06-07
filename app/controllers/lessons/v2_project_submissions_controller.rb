module Lessons
  class V2ProjectSubmissionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lesson

    def index
      @pagy, @project_submissions = pagy(public_project_submissions, items: params.fetch(:limit, 15))
    end

    private

    def public_project_submissions
      project_submissions_query.public_submissions
    end

    def project_submissions_query
      @project_submissions_query ||= ::LessonProjectSubmissionsQuery.new(
        lesson: @lesson,
        current_user:
      )
    end

    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end
  end
end
