module Admin
  class PasswordsController < Devise::PasswordsController
    def new
      redirect_to new_admin_user_session_path, alert: 'Please sign in'
    end

    def create
      redirect_to new_admin_user_session_path, alert: 'Please sign in'
    end

    private

    def after_resetting_password_path_for(_resource)
      admin_dashboard_path
    end
  end
end
