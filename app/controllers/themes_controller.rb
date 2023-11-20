class ThemesController < ApplicationController
  before_action :cache_previous_theme

  def update
    @new_theme = Users::Theme.for(params[:theme])

    respond_to do |format|
      if @new_theme.present?
        change_current_theme(params[:theme])

        format.turbo_stream
      else
        flash.now[:alert] = "Sorry, we can't find that theme."
        format.turbo_stream { render turbo_stream: turbo_stream.update('flash-messages', partial: 'shared/flash') }
      end
    end
  end

  private

  def cache_previous_theme
    @previous_theme = current_theme
  end
end
