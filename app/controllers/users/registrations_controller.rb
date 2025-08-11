class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  protected

  def after_sign_up_path_for(_resource)
    dashboard_path
  end

  def after_inactive_sign_up_path_for(_resource)
    dashboard_path
  end
end
