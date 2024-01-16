module Lessons
  class ProjectSubmissionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lesson
    before_action :can_add_solution

    def index
      @current_user_submission = current_user.project_submissions.find_by(lesson: @lesson)
      @pagy, @project_submissions = pagy_array(project_submissions_query, items: params.fetch(:limit, 15))
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
          @project_submission.like(current_user)

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

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def project_submissions_query
      @project_submissions_query ||= ::LessonProjectSubmissionsQuery.new(
        lesson: @lesson,
        current_user:
      )

      ProjectSubmissions::MarkLiked.call(
        user: current_user,
        project_submissions: @project_submissions_query.public_submissions
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

    def can_add_solution
      return if @lesson.accepts_submission?

      redirect_to lesson_url(@lesson), alert: 'This project does not accept submissions'
    end
  end
end
