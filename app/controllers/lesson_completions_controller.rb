class LessonCompletionsController < ApplicationController
  before_action :authenticate_user!

  # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
  def create
    @step = Step.find(params[:lesson_id])
    lesson = @step.learnable

    lesson_completion = current_user.lesson_completions.new(
      lesson: lesson,
      lesson_identifier_uuid: lesson.identifier_uuid,
      course_id: @step.parent_course,
      path_id: @step.path,
    )

    if lesson_completion.save
      render json: lesson_completion, status: :created
    else
      render json: { errors: lesson_completion.errors.full_messages }, status: :unprocessable_entity
    end
  end
  # rubocop: enable Metrics/AbcSize, Metrics/MethodLength

  def destroy
    step = Step.find(params[:lesson_id])
    lesson_completion = current_user.lesson_completions.find_by(lesson: step.learnable)

    if lesson_completion.present?
      lesson_completion.destroy
      render json: {}, status: :ok
    else
      render json: { errors: ['Lesson completion not found'] }, status: :not_found
    end
  end

  private

  # def lesson
  #   @lesson ||= LessonDecorator.new(
  #     Lesson.find(params[:lesson_id])
  #   )
  # end
end
