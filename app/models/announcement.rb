class Announcement < ApplicationRecord
  validates :message, presence: true
  validates :expires_at, presence: true

  scope :active, -> { where(expires_at: Time.zone.now..).order(created_at: :desc) }
  scope :expired, -> { where(expires_at: ...Time.zone.now) }
  scope :showable_messages, ->(disabled_ids) { active.where.not(id: disabled_ids) }
  scope :ordered_by_recent, -> { order(created_at: :desc) }

  belongs_to :user, optional: true

  def self.for_status(status)
    {
      active:,
      expired:
    }.fetch(status.to_sym) { active }
  end
end
