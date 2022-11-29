class ThemesController < ApplicationController
  def update
    theme = params[:theme]

    if Users::Theme.exists?(theme)
      change_current_theme(theme)

      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream
      end
    else
      redirect_back(fallback_location: root_path, alert: "Sorry, we can't find that theme.", status: :see_other)
    end
  end
end
