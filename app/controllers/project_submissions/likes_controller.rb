class ProjectSubmissions::LikesController < ApplicationController
  before_action :authenticate_user!

  def update
    if policy.allowed?
      @project_submission = ProjectSubmission.find(params[:project_submission_id])
      toggle

      respond_to do |format|
        format.turbo_stream
      end
    else
      send_error_flash
    end
  end

  private

  def toggle
    if @project_submission.liked_by?(current_user)
      @project_submission.unlike(current_user)
    else
      @project_submission.like(current_user)
    end
  end

  def send_error_flash
    respond_to do |format|
      flash.now[:alert] = 'Your account is either too young or has not submitted a project.'
      format.turbo_stream { render turbo_stream: turbo_stream.update('flash-messages', partial: 'shared/flash') }
    end
  end

  def policy
    SubmissionVotePolicy.new(current_user)
  end
end
