class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super

    if resource.persisted? && ENV['STAGING'].nil?
      UserMailer.send_welcome_email_to(resource).deliver_later
    end
  end

  protected

  def after_sign_up_path_for(_resource)
    dashboard_path
  end

  def after_inactive_sign_up_path_for(_resource)
    dashboard_path
  end
end
