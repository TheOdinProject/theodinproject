module MailchimpHelper
  # Helper function to create
  # a Gibbon request
  def mailchimp_create_request
    Gibbon::Request.new(
      api_key: ENV['MAILCHIMP_API_KEY']
    )
  end

  def mailchimp_get_members(list_id)
    mailchimp_create_request
      .lists(list_id)
      .members
      .retrieve
  end

  def mailchimp_member_exists?(email, list_id)
    response = mailchimp_get_members(list_id)
    members = response.body['members']
    members.any? do |member|
      member['email_address'] == email
    end
  end

  # Helper function to remove
  # a member from a list only
  # if the member exists in that list
  def mailchimp_remove_member(email, list_id)
    # Get list members from API
    response = mailchimp_get_members(list_id)

    # If email is in members
    emails = []
    members = response.body['members']
    members.each do |member|
      emails << member['email_address']
    end

    if emails.include?(email)

      # MailChimp uses the MD5 hash
      # of a user's email as their ID
      md5 = Digest::MD5.new
      member_id = md5.hexdigest(email)

      # Delete the member
      mailchimp_delete_member(list_id, member_id)
    end
  end

  private

  def mailchimp_delete_member(list_id, member_id)
    mailchimp_create_request
      .lists(list_id)
      .members(member_id)
      .delete
  end
end











