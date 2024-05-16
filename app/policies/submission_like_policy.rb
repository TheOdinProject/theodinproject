class SubmissionLikePolicy
  def initialize(user)
    @user = user
  end

  def allowed?
    return true if @user.project_submissions.any?

    no_recent_accounts_with_same_ip?
  end

  private

  def no_recent_accounts_with_same_ip?
    User
      .created_after(1.week.ago)
      .where(last_sign_in_ip: @user.current_sign_in_ip)
      .where.not(id: @user.id)
      .none?
  end
end
