class NudgeMailer < ActionMailer::Base
  include MailCampaignHelper
  default from: "no-reply@theodinproject.com"
  default to: "no-reply@theodinproject.com"

  def inactive_one_month
    recipients = User.where('last_sign_in_at > ?', Time.now - 1.month)
    send_mail("inactive_one_month", recipients)
  end


end
