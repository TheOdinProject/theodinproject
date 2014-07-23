class TestMailer < ActionMailer::Base
  default from: "no-reply@theodinproject.com"
  default to: "no-reply@theodinproject.com"

  class Error < RuntimeError
  end

  class NoCampaignError < Error
  end

  class NoCampaignCategoryError < Error
    def message
      "Email campaign does not belong to a category"
    end
  end

  def email_one_person
    check_campaign("TestMailer.email_one_person")
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


  protected

  def record(email, recipient)
    sent = SentEmail.new
    sent.email_campaign = EmailCampaign.find_by_method_name(email)
    sent.user = recipient
    sent.save
  end

  def check_campaign(email)
    campaign = EmailCampaign.find_by_method_name(email)
    if campaign == nil
      raise NoCampaignError, "This email does not match any known campaigns.
      Please create a campaign before sending.
      The method name in the campaign should be #{email}"
    end
    if campaign.email_campaign_category == nil
      raise NoCampaignCategoryError
    end
  end


end
