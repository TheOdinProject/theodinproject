class ProjectSubmissions::V2LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @project_submission = ProjectSubmission.find(params[:project_submission_id])
    @project_submission.like!(current_user)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @project_submission = ProjectSubmission.find(params[:project_submission_id])
    @project_submission.unlike!(current_user)

    respond_to do |format|
      format.turbo_stream { render :create }
    end
  end
end
