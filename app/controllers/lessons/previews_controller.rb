module Lessons
  class PreviewsController < ApplicationController
    def show
      @preview = LessonPreview.find_or_initialize_by(id: params[:uuid])
    end

    def create
      @preview = LessonPreview.new(content: params[:markdown])

      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end
