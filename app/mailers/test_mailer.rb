class TestMailer < ActionMailer::Base
  default from: "no-reply@theodinproject.com"
  default to: "no-reply@theodinproject.com"

  def email_one_person
    # RECIPIENT AND HEADER BUILT INTO METHOD
    recipient = User.last
    smtpapi = {
      "to" => [
        recipient.email
      ]
    }
    header = smtpapi.to_json
    headers["X-SMTPAPI"] = header
    mail.deliver
    record("TestMailer.email_one_person", recipient)
  end


  private

  def record(email, recipient)
    sent = SentEmail.new
    sent.email_campaign = EmailCampaign.find_by_method_name(email)
    sent.user = recipient
    sent.save
  end
end
