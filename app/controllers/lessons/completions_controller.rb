module Lessons
  class CompletionsController < ApplicationController
    before_action :authenticate_user!

    # rubocop: disable Metrics/MethodLength
    def create
      @lesson = Lesson.find(params[:lesson_id])

      lesson_completion = current_user.lesson_completions.find_or_create_by!(
        lesson: @lesson,
        lesson_identifier_uuid: @lesson.identifier_uuid,
        course: @lesson.course,
        path: @lesson.course.path,
      )

      if lesson_completion
        @lesson.complete!

        respond_to do |format|
          format.html { redirect_to @lesson }
          format.turbo_stream
        end
      else
        redirect_to @lesson, alert: 'Cannot complete lesson', status: :unprocessable_entity
      end
    end
    # rubocop: enable Metrics/MethodLength

    # rubocop: disable Metrics/MethodLength
    def destroy
      @lesson = Lesson.find(params[:lesson_id])
      lesson_completion = current_user.lesson_completions.find_by!(lesson: @lesson)

      if lesson_completion.present?
        @lesson.incomplete!
        lesson_completion.destroy

        respond_to do |format|
          format.html { redirect_to @lesson }
          format.turbo_stream { render :create }
        end
      else
        redirect_to @lesson, alert: 'Cannot uncomplete lesson', status: :unprocessable_entity
      end
    end
    # rubocop: enable Metrics/MethodLength
  end
end
