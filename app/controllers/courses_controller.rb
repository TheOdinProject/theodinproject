class CoursesController < ApplicationController
  def show
    @path = Path.friendly.find(params[:path_id])
    @course = path.courses.friendly.find(params[:id])

    @path_step = Step.find_by!(path: @path, learnable: @course)
    # Step.find_by(path: params[:path_id], learnable: params[:id], learnable_type: 'Course')


    # @course = @step.learnable
    # @path = @step.path
    @sections = @course.sections.includes(:lessons)
  end

  private

  def course
    path.courses.friendly.find(params[:id])
  end

  def path
    Path.find(params[:path_id])
  end
end
