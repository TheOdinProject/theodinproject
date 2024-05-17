class ProjectSubmissions::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_like

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

  private

  def authorize_like
    return if SubmissionLikePolicy.new(current_user).allowed?

    respond_to do |format|
      flash.now[:alert] = 'Failed to like.'
      format.turbo_stream { render turbo_stream: turbo_stream.update('flash-messages', partial: 'shared/flash') }
    end
  end
end
