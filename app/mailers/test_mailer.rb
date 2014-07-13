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
    return mail
  end

end