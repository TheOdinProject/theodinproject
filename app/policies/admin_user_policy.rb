class AdminUserPolicy
  def initialize(admin_user)
    @admin_user = admin_user
  end

  def change_role?
    admin_user.core?
  end

  def invite?
    admin_user.core? || admin_user.maintainer?
  end

  def deactivate?
    admin_user.core?
  end

  def reactivate?
    admin_user.core? || admin_user.maintainer?
  end

  def reset_2fa?
    admin_user.core?
  end

  private

  attr_reader :admin_user
end
