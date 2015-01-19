class TestMailer < ActionMailer::Base
  include MailCampaignHelper
  default from: "no-reply@theodinproject.com"
  default to: "no-reply@theodinproject.com"

  def email_one_person
    recipients = User.all
    send_mail("email_one_person", recipients)
  end

end
