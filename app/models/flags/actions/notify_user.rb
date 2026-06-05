class Flags::Actions::NotifyUser < Flags::Actions::Base
  def perform # rubocop:disable Metrics/AbcSize
    ActiveRecord::Base.transaction do
      flag.project_submission.update!(discard_at: 7.days.from_now)
      flag.resolve(action_taken: :notified_user, resolved_by: admin_user)
    end

    if flag.resolved?
      send_notification
      Result.new(success: true, message: 'Notification sent')
    else
      Result.new(success: false, message: flag.errors.full_messages.join(', '))
    end
  end

  private

  def send_notification
    Notifications::DeadLinkNotification.new(flag).deliver
  end
end
