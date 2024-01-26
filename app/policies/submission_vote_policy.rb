class SubmissionVotePolicy
  def initialize(user)
    @user = user
  end

  def allowed?
    return true if user_has_submissions

    !another_acct_created_recently
  end

  private

  def another_acct_created_recently
    User.where(last_sign_in_ip: @user.current_sign_in_ip).where.not(id: @user.id).any?
  end

  def user_has_submissions
    @user.project_submissions.any?
  end
end
