module Admin
  class SessionsController < Devise::SessionsController
    include TwoFactorAuthentication

    before_action :configure_permitted_parameters, if: :devise_controller?

    private

    def after_sign_in_path_for(_resource)
      admin_dashboard_path
    end

    def after_sign_out_path_for(_resource_or_scope)
      new_admin_user_session_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end
  end
end
