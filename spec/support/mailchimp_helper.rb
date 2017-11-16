module MailchimpHelper
  # Helper function to create a Gibbon request
  def mailchimp_create_request
    Gibbon::Request.new(
      api_key: ENV['MAILCHIMP_API_KEY']
    )
  end

  # Get all members in list
  def mailchimp_get_members(list_id)
    mailchimp_create_request
      .lists(list_id)
      .members
      .retrieve
  end

  # Check if a member exists in a list by email
  def mailchimp_member_exists?(email, list_id)
    response = mailchimp_get_members(list_id)
    members = response.body['members']
    members.any? { |member| member['email_address'] == email }
  end

  # Helper function to remove a member from a list
  # only if the member exists in that list
  def mailchimp_remove_member(email, list_id)
    # Get list members from API
    response = mailchimp_get_members(list_id)

    emails = []
    members = response.body['members']
    members.each { |member| emails << member['email_address'] }

    # Is the email in the list?
    if emails.include?(email)

      # MailChimp uses the MD5 hash of a user's email as their ID
      md5 = Digest::MD5.new
      member_id = md5.hexdigest(email)

      # Delete the member
      mailchimp_delete_member(list_id, member_id)
    end
  end

  private

  # Submits the delete request to remove a member from a list
  def mailchimp_delete_member(list_id, member_id)
    mailchimp_create_request
      .lists(list_id)
      .members(member_id)
      .delete
  end
end











