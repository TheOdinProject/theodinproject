class MailchimpSubscription

  # Creates a member on the mailchimp mailing list with the given options
  #
  # @param [Hash] options The attributes of the mailing list member
  # @option options [String] :email The member's email
  # @option options [String] :username The member's username
  # @option options [String] :signup_date The date at which the member signed up or registered
  # @return [Gibbon::Response] The response from the mailchimp API
  def self.create(options)
    email = options[:email]
    username = options[:username]
    signup_date = options[:signup_date]

    merge_fields = {
      USERNAME: username,
      SIGNUPDATE: signup_date
    }

    create_request
      .lists(ENV['MAILCHIMP_LIST_ID'])
      .members
      .create(
        body: {
          email_address: email,
          status: :subscribed,
          merge_fields: merge_fields
        }
      )
  end

  private

  # Creates a new mailchimp request
  # @return [Gibbon::Request] The request
  def self.create_request
    Gibbon::Request.new(
      api_key: ENV['MAILCHIMP_API_KEY']
    )
  end
end







