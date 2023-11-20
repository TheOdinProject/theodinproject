class ProjectSubmissions::LikesController < ApplicationController
  before_action :authenticate_user!

  def update
    @project_submission = ProjectSubmission.find(params[:project_submission_id])

    if @project_submission.liked_by?(current_user)
      @project_submission.unlike(current_user)
    else
      @project_submission.like(current_user)
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
