class Paths::CoursesController < ApplicationController
  before_action :authenticate_user!

  def show
    @step = Step.find_by(path: params[:path_id], learnable: params[:id], learnable_type: 'Course')

    @course = @step.learnable
    @sections = @course.sections
  end
end
