class TestMailer < ActionMailer::Base
  default from: "no-reply@theodinproject.com"
  default to: "no-reply@theodinproject.com"

  def send_test_email(header)
    puts "Sending test email..."
    
    # FIRST DRAFT - HEADER BUILT IN METHOD
    # smtpapi = {
    #   "to" => [
    #     "grace@shiba.inu",
    #     "jesse@shiba.inu"
    #   ]
    # }
    # header = smtpapi.to_json

    # SECOND DRAFT - RAKE TASK BUILDS HEADER
    headers["X-SMTPAPI"] = header
    return mail
  end

end