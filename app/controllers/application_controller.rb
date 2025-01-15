class ApplicationController < ActionController::Base
  include CurrentTheme
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_sentry_user, if: :current_user
  before_action :store_user_location!, if: :storable_location?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def not_found_error
    render 'errors/not_found', status: :not_found
  end

  private

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def storable_location?
    controller_path == 'lessons' && action_name == 'show'
  end

  def set_sentry_user
    Sentry.set_user(id: current_user.id, email: current_user.email)
  end

  def set_cache_control_header_to_no_store
    response.cache_control.replace(no_store: true)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :username, :current_password, :password, :password_confirmation, :learning_goal)
    end
  end
end
