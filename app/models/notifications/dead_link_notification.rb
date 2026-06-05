class Notifications::DeadLinkNotification
  include Rails.application.routes.url_helpers

  def initialize(flag)
    @flag = flag
  end

  def deliver
    recipient.notifications.create!(
      title:,
      message:,
      url:
    )
  end

  private

  attr_reader :flag

  def recipient
    submission.user
  end

  def title
    "One of your submissions has been flagged on #{flagged_date}"
  end

  def message
    "Hey #{recipient.username}, your project #{lesson_name} has a broken link in your submission. " \
      "Please update it by #{submission_deletion_date} so it doesn't get removed!"
  end

  def url
    lesson_url(submission.lesson, only_path: true)
  end

  def submission
    flag.project_submission
  end

  def flagged_date
    flag.created_at.strftime('%d %b %Y')
  end

  def lesson_name
    submission.lesson.display_title
  end

  def submission_deletion_date
    7.days.from_now.strftime('%d %b %Y')
  end
end
