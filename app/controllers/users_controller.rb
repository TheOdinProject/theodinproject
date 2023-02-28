class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @courses = current_user.path.courses
  end
end
