class SubmissionVotePolicy
  def initialize(user)
    @user = user
  end

  def allowed?
    user_has_submissions && account_older_than_7_days
  end

  private

  def user_has_submissions
    @user.project_submissions.any?
  end

  def account_older_than_7_days
    @user.created_at < Time.zone.today - 7.days
  end
end
