module Lessons
  class PreviewsController < ApplicationController
    def show; end

    def create
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
  end
end
