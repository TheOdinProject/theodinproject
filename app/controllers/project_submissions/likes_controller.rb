class ProjectSubmissions::LikesController < ApplicationController
  include ProjectsHelper
  before_action :authenticate_user!

  def create
    @project_submission = ProjectSubmission.find(params[:submission_id])
    @project_submission.liked_by current_user

    render json: { message: "Project #{@project_submission.id} liked!" }
  end
end
