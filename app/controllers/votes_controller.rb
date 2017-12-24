class VotesController < ApplicationController
  before_action :authenticate_request, only: %i(create destroy)
  before_action :set_project
  before_action :check_owner, only: %i(create destroy)

  def index
    render json: @project.total_votes
  end

  def create
    @project.upvote_for(current_user)
    @decorated_project = ProjectDecorator.new(@project)
  end

  def destroy
    @project.remove_vote_for(current_user)
    @decorated_project = ProjectDecorator.new(@project)
  end

  private

  def check_owner
    head :bad_request if @project.user == current_user
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authenticate_request
    head :unauthorized unless user_signed_in?
  end
end
