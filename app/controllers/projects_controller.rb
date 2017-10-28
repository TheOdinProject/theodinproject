class ProjectsController < ApplicationController
  before_action :authenticate_request, except: :index
  before_action :find_lesson
  before_action :find_project, only: %i(update destroy)

  authorize_resource only: %i(update destroy)

  def index
    @projects = projects
    @course = CourseDecorator.new(@lesson.course)
  end

  def create
    @project = new_project(project_params)
    @project.save
    set_recent_submissions
  end

  def update
    @project.update(project_params)
  end

  def destroy
    @project.destroy
    @project = new_project
    set_recent_submissions
  end

  private

  def projects
    all_projects.page(params[:page])
  end

  def set_recent_submissions
    @submissions = all_projects.where.not(user_id: current_user.id).limit(10)
  end

  def all_projects
    Project.all_submissions(@lesson.id)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def new_project(params = {})
    current_user.projects.new(**params, lesson_id: @lesson.id)
  end

  def project_params
    params.require(:project).permit(:repo_url, :live_preview)
  end

  def lesson
    Lesson.friendly.find(params[:lesson_id])
  end

  def find_lesson
    @lesson = LessonDecorator.new(lesson)
  end

  def authenticate_request
    return head :unauthorized unless user_signed_in?
  end
end
