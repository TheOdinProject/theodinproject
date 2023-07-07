module Lessons
  class V2ProjectSubmissionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lesson

    def index
      @current_user_submission = current_user.project_submissions.find_by(lesson: @lesson)
      @pagy, @project_submissions = pagy(project_submissions_query.public_submissions, items: params.fetch(:limit, 15))
    end

    def new
      @project_submission = current_user.project_submissions.new(lesson: @lesson)
    end

    def edit
      @project_submission = current_user.project_submissions.find(params[:id])
    end

    def create
      @project_submission = current_user.project_submissions.new(project_submission_params.merge(lesson: @lesson))

      respond_to do |format|
        if @project_submission.save
          format.html { redirect_to lesson_path(@lesson), notice: 'Project submitted' }
          format.turbo_stream
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      @project_submission = current_user.project_submissions.find(params[:id])

      respond_to do |format|
        if @project_submission.update(project_submission_params)
          format.html { redirect_to lesson_path(@lesson), notice: 'Project updated' }
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @project_submission = current_user.project_submissions.find(params[:id])
      @project_submission.destroy

      render turbo_stream: turbo_stream.remove(@project_submission)
    end

    private

    def project_submissions_query
      @project_submissions_query ||= ::LessonProjectSubmissionsQuery.new(
        lesson: @lesson,
        current_user:
      )
    end

    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    def project_submission_params
      params.require(:project_submission).permit(
        :repo_url,
        :live_preview_url,
        :is_public,
        :lesson_id
      )
    end
  end
end
