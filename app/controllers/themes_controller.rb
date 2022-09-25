class ThemesController < ApplicationController
  ALLOWED_THEMES = %w[light dark].freeze

  def update
    theme = params[:theme]

    if ALLOWED_THEMES.include?(theme)
      change_current_theme(theme)

      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream
      end
    else
      redirect_back(fallback_location: root_path, alert: 'Sorry, that theme is not allowed.', status: :see_other)
    end
  end
end
