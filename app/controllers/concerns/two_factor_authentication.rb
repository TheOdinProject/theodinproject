module TwoFactorAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_with_two_factor, if: :two_factor_enabled?, only: [:create]
  end

  private

  def two_factor_enabled?
    resource = find_resource
    resource&.two_factor_enabled?
  end

  def authenticate_with_two_factor
    self.resource = find_resource

    if resource_params[:otp_attempt].present? && cookies.encrypted[:otp_id].present?
      authenticate_resource_with_two_factor
    elsif resource.valid_password?(resource_params[:password])
      prompt_for_otp
    end
  end

  def find_resource
    @find_resource ||=
      resource_class.find_by(id: cookies.encrypted[:otp_id]) || resource_class.find_by(email: resource_params[:email])
  end

  def authenticate_resource_with_two_factor
    if valid_otp_attempt?
      cookies.delete(:otp_id)

      sign_in(resource, event: :authentication)
    else
      flash.now[:alert] = 'Invalid authentication code.'
      prompt_for_otp
    end
  end

  def valid_otp_attempt?
    resource.validate_and_consume_otp!(resource_params[:otp_attempt])
  end

  def prompt_for_otp
    cookies.encrypted[:otp_id] = { value: resource.id, expires: 5.minutes.from_now }
    render "#{devise_mapping.path}/sessions/two_factor", status: :see_other
  end

  def resource_params
    params.require(resource_name).permit(:email, :password, :otp_attempt)
  end
end
