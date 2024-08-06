module CurrentTheme
  extend ActiveSupport::Concern

  included do
    before_action :set_default

    helper_method :current_theme
  end

  private

  def set_default
    return if cookies[:theme].present?

    cookies.permanent[:theme] = 'light'
  end

  def change_current_theme(theme)
    cookies.permanent[:theme] = theme
  end

  def current_theme
    @current_theme ||= Users::Theme.for(cookies[:theme]) || Users::Theme.for('light')
  end
end
