class BanMailer < ApplicationMailer
  default from: 'The Odin Project <contact@theodinproject.com>'

  def send_ban_email_to(user)
    @user = user

    mail(
      subject: 'You Have Been Banned From The Odin Project',
      to: user.email,
      template_name: 'ban_email',
    )
  end
end
