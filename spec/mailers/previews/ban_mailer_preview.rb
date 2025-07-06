class UserMailerPreview < ActionMailer::Preview
  def ban_email
    UserMailer.with(user: User.first).send_ban_email_to(User.first)
  end
end
