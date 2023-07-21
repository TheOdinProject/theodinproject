module Users
  class ProjectSubmissionsController < ApplicationController
    before_action :authenticate_user!

    def edit
      @project_submission = current_user.project_submissions.find(params[:id])
    end

    def update
      @project_submission = current_user.project_submissions.find(params[:id])

      respond_to do |format|
        if @project_submission.update(project_submission_params)
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def project_submission_params
      params.require(:project_submission).permit(:repo_url, :live_preview_url, :is_public)
    end
  end
end
