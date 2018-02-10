class VotesController < ApplicationController
  before_action :authenticate_request

  def create
    @project = Project.find(params[:project_id])
    check_self_voting
    @project.upvote_for(current_user)
    @decorated_project = ProjectDecorator.new(@project)
  end

  def destroy
    @project = Project.find(params[:project_id])
    check_self_voting
    @project.remove_vote_for(current_user)
    @decorated_project = ProjectDecorator.new(@project)
  end

  private

  def check_self_voting
    head :bad_request if @project.user == current_user
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authenticate_request
    head :unauthorized unless user_signed_in?
  end
end
