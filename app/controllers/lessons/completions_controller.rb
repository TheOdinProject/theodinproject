module Lessons
  class CompletionsController < ApplicationController
    before_action :authenticate_user!

    # rubocop: disable Metrics/MethodLength
    def create
      lesson = Lesson.find(params[:lesson_id])

      lesson_completion = current_user.lesson_completions.find_or_create_by(
        lesson:,
        lesson_identifier_uuid: lesson.identifier_uuid,
        course: lesson.course,
        path: lesson.course.path,
      )

      if lesson_completion
        render json: lesson_completion, status: :created
      else
        render json: { errors: lesson_completion.errors.full_messages }, status: :unprocessable_entity
      end
    end
    # rubocop: enable Metrics/MethodLength

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
end
