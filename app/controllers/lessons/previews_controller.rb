module Lessons
  class PreviewsController < ApplicationController
    # GET /lessons/preview
    def show
      @preview = LessonPreview.find_or_initialize_by(id: params[:uuid])
    end

    # POST /lessons/preview
    def create
      preview_link = LessonPreview.new(lesson_preview_params)

      if preview_link.save
        render json: { preview_link: lessons_preview_url(uuid: preview_link.id) }, status: :created
      else
        render json: { errors: preview_link.errors.full_messages }, status: :unprocessable_entity
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
  end
end
