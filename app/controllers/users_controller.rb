class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @courses = current_user.path.courses
    @project_submissions = current_user.project_submissions.includes(:lesson).order(created_at: :desc)
  end
end
