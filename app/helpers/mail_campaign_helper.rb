module MailCampaignHelper
  class Error < RuntimeError
  end

  class NoCampaignError < Error
  end

  class NoCampaignCategoryError < Error
    def message
      "Email campaign does not belong to a category"
    end
  end

  def send_mail(method, users)
    campaign = check_campaign(method)
    # Filter users and return two arrays - 
    # One of Users and one of their email addresses
    filtered_list = filter(users, campaign)

    recipients = filtered_list[0]
    if recipients == []
      puts "No recipients match criteria for email"
      return
    end

    # Use array of addresses for smtpapi header
    recipient_addresses = filtered_list[1]
    build_header(recipient_addresses)

    mail.deliver

    # Use array of User objects to record sent mail
    record(campaign, recipients)
  end

  def check_campaign(method)
    campaign = EmailCampaign.find_by_method_name(method)
    if campaign == nil
      raise NoCampaignError, "This email method name does not match any known campaigns.
      Please create a campaign before sending.
      The method name in the campaign should be #{method}"
    end
    if campaign.email_campaign_category == nil
      raise NoCampaignCategoryError
    end
    return campaign
  end

  def filter(users, campaign)
    users =  users.where(unsubscribe_all: false).
                   where.not(confirmed_at: nil).
                   includes(:unsubscriptions).
                   includes(:sent_emails)
    recipients = []
    recipient_addresses = []
    # Filter users who have received this email or unsubscribed from this category
    users.each do |user|
      if user.sent_emails.where(email_campaign_id: campaign.id) == [] &&
         user.unsubscriptions.where(
          email_campaign_category_id: campaign.email_campaign_category_id) == []
        recipients << user
        recipient_addresses << user.email
      end
    end
    return recipients, recipient_addresses
  end

  def build_header(recipients)
    header = {
      "filters" => {
        "subscriptiontrack" => {  # Tell Sendgrid not to 
            "settings" => {       # add an Unsubscribe link
                "enable" => 0     # because theirs is always
            }                     # unsubscribe all
        }
    },
      "to" => recipients          # Build list of addresses
    }.to_json
    headers["X-SMTPAPI"] = header
  end

  def record(campaign, recipients)
    recipients.each do |recipient|
      sent = SentEmail.new
      sent.email_campaign = campaign
      sent.user = recipient
      sent.save
    end
  end
      
end
