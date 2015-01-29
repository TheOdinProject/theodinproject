class LessonCompletionsController < ApplicationController
  
  before_filter :authenticate_request
  before_action :set_lesson, only: [:create, :destroy]
  before_action :validate_lesson, only: [:create, :destroy]
  before_action :set_course, only: [:create, :destroy]
  before_action :set_next_lesson, only: [:create, :destroy]

  def create
    # Validate that the id does in fact correspond to a real lesson
    # Note that the authentication before_filter makes sure we've got a current_user

    lc = LessonCompletion.new(:student_id => current_user.id, :lesson_id => @lesson.id)

    if lc.save
      render "create", :formats => [:js]
    else
      render_bad_request
    end
  end

  def destroy
    # Validate that the id does in fact correspond to a real lessons
    # Note that the authentication before_filter makes sure we've got a current_user

    lc = LessonCompletion.where(:student_id => current_user.id, :lesson_id => @lesson.id).first

    if lc.nil? || !lc.delete
      render_bad_request
    else
      render "create", :formats => [:js] 
    end
  end

  private
    def authenticate_request
      unless user_signed_in?
        render :nothing => true, :status => 401 # unauthorized
      end
    end

    def render_bad_request
      render :nothing => true, :status => 400
    end

    def set_lesson
      @lesson = Lesson.where(:id => params[:lesson_id]).first
    end

    def validate_lesson
      @lesson || render_bad_request
    end

    def set_course
      @course = @lesson.course
    end

    def set_next_lesson
      @next_lesson = @lesson.next_lesson
    end
end
