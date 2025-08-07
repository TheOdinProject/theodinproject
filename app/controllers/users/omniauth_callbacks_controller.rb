class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  after_action :send_welcome_email, only: [:github, :google]
  def github
    @user = UserProvider.find_user(auth)

    update_users_avatar if avatar_needs_updated?

    if @user.persisted?
      @user.remember_me = true
      sign_in_and_redirect @user
    else
      session['devise.github_data'] = auth
      redirect_to new_user_registration_url
    end
  end
  alias google github

  def failure
    redirect_to new_user_session_path, alert: 'Authentication failed'
  end

  private
  def send_welcome_email
    return unless  @user&.persisted? && @user.sign_in_count == 1 && ENV['STAGING'].nil?

    UserMailer.send_welcome_email_to(@user).deliver_now
  end
  def update_users_avatar
    @user.update!(avatar: avatar_from_provider)
  end

  def avatar_needs_updated?
    avatar_from_provider != @user.avatar
  end

  def avatar_from_provider
    @avatar_from_provider ||= auth.info.image
  end

  def auth
    request.env['omniauth.auth']
  end
end
