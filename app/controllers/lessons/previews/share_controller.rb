module Lessons
  module Previews
    class ShareController < ApplicationController
      def create
        @preview = LessonPreview.new(content: params[:content])

        respond_to do |format|
          if @preview.save
            format.turbo_stream
          else
            flash.now[:alert] = 'Unable to share preview'

            format.turbo_stream { render turbo_stream: turbo_stream.update('flash-messages', partial: 'shared/flash') }
          end
        end
      end
    end
  end
end
