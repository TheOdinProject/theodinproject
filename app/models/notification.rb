class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  scope :unread, -> { where(read_at: nil) }

  def read?
    read_at.present?
  end

  def unread?
    !read?
  end

  def mark_as_read!
    update(read_at: Time.current)
  end
end
