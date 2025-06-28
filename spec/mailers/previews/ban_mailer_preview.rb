class BanMailerPreview < ActionMailer::Preview
  def ban_email
    BanMailer.with(user: User.first).send_ban_email_to(User.first)
  end
end
