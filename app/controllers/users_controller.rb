class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @courses = decorated_path_courses
  end

  private

  def decorated_path_courses
    current_user.path.courses.map do |course|
      CourseDecorator.new(course)
    end
  end
end
