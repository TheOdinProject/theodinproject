module TwoFactorAuthenticatable
  extend ActiveSupport::Concern

  def generate_two_factor_secret_if_missing!
    return if otp_secret.present?

    update!(otp_secret: self.class.generate_otp_secret)
  end

  def two_factor_qr_code_uri
    otp_provisioning_uri(email, issuer: 'The Odin Project')
  end

  def enable_two_factor!
    update!(otp_required_for_login: true)
  end

  def two_factor_enabled?
    otp_required_for_login
  end

  def reset_two_factor!
    update!(otp_required_for_login: false, otp_secret: nil, consumed_timestep: nil)
  end
end
