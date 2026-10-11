class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
  scope :newest_first, -> { order(created_at: :desc) }

  after_create_commit :broadcast_created

  def read?
    read_at.present?
  end

  def unread?
    !read?
  end

  def mark_as_read!
    update(read_at: Time.current)
  end

  private

  def broadcast_created
    broadcast_to_list
    broadcast_unread_indicator
  end

  def broadcast_to_list
    broadcast_prepend_to(
      [recipient, :notifications],
      target: 'notifications',
      partial: 'notifications/notification',
      locals: { notification: self }
    )
  end

  def broadcast_unread_indicator
    broadcast_replace_to(
      [recipient, :notifications],
      target: 'notification_bell',
      partial: 'shared/notification_bell',
      locals: { user: recipient }
    )
  end
end
