class Announcement < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin_user, optional: true

  validates :message, presence: true
  validates :message, length: { maximum: 100 }
  validates :expires_at, presence: true
  validates :learn_more_url, url: true, allow_blank: true
  validate :expiry_must_be_in_the_future

  scope :active, -> { where(expires_at: Time.zone.now..).order(created_at: :desc) }
  scope :expired, -> { where(expires_at: ...Time.zone.now) }
  scope :showable_messages, ->(disabled_ids) { active.where.not(id: disabled_ids) }
  scope :ordered_by_recent, -> { order(created_at: :desc) }

  def self.for_status(status)
    {
      active:,
      expired:
    }.fetch(status.to_sym) { active }
  end

  def status
    return :active if expires_at > Time.zone.now

    :expired
  end

  def active?
    status == :active
  end

  def created_by
    admin_user || Null::AdminUser.new
  end

  private

  def expiry_must_be_in_the_future
    return if expires_at.present? && expires_at > Time.zone.today

    errors.add(:expires_at, 'expiry must be greater than today')
  end
end
