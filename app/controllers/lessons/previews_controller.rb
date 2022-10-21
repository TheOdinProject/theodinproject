module Lessons
  class PreviewsController < ApplicationController
    def show
      @preview = LessonPreview.find_or_initialize_by(id: params[:uuid])
    end

    def create
      previewLesson = LessonPreview.create(lesson_preview_params)

      if previewLesson
        render json: { preview_link: preview_link(previewLesson.id) }
      else
        render json: { error: "Preview can't be created" }
      end
    end

    def markdown
      if content.present?
        render json: { content: MarkdownConverter.new(params[:content]).as_html }
      else
        render json: { content: '<p>Nothing to preview</p>' }
      end
    end

    private

    def content
      params[:content]
    end

    def lesson_preview_params
      params.permit(:content)
    end

    def preview_link(lesson_id)
      lessons_preview_url(uuid: lesson_id)
    end
  end
end
