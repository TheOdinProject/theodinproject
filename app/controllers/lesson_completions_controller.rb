class LessonCompletionsController < ApplicationController
  before_action :authenticate_user!

  def create
    lesson = Lesson.find(params[:lesson_id])

    lesson_completion = current_user.lesson_completions.new(
      lesson:,
      lesson_identifier_uuid: lesson.identifier_uuid,
    )

    if lesson_completion.save
      render json: lesson_completion, status: :created
    else
      render json: { errors: lesson_completion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    lesson = Lesson.find(params[:lesson_id])
    lesson_completion = current_user.lesson_completions.find_by(lesson:)

    if lesson_completion.present?
      lesson_completion.destroy
      render json: {}, status: :ok
    else
      render json: { errors: ['Lesson completion not found'] }, status: :not_found
    end
  end
end
