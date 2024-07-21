require 'devise_two_factor/spec_helpers'

def otp_code_for(user)
  ROTP::TOTP.new(user.otp_secret).at(Time.zone.now)
end
