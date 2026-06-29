class ExpireAnnouncementsJob < ApplicationJob
  queue_as :default

  def perform
    Announcement.active.where(expires_at: ...Time.zone.now).update_all(status: :expired)
  end
end
