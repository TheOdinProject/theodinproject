class Dashboard::CourseButtonComponent < ApplicationComponent
  def initialize(course_step:, current_user:)
    @course_step = course_step
    @current_user = current_user
  end

  def resume_lesson_path
    return path_course_path(path, course) if end_of_course?

    path_lesson_path(path, next_step.learnable)
  end

  private

  attr_reader :course_step, :current_user

  def course
    course_step.learnable
  end

  def path
    current_user.path
  end

  def latest_completed_lesson
    @latest_completed_lesson ||=
      current_user.lesson_completions.for_course_lessons(course).most_recent.lesson
  end

  def next_step
    @next_step ||= course_step.leaves.find_by(learnable: latest_completed_lesson).next
  end

  def end_of_course?
    next_step.nil?
  end

  def lesson_completions_for_course
    current_user.lesson_completions.for_course_lessons(course)
  end
end
