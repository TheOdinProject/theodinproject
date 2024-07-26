class AdminUser < ApplicationRecord
  include TwoFactorAuthenticatable
  include PublicActivity::Common

  devise :two_factor_authenticatable
  devise :invitable, :recoverable, :trackable, :timeoutable, :validatable,
         password_length: 8..128

  belongs_to :reactivated_by, class_name: 'AdminUser', optional: true

  validates :name, presence: true, uniqueness: true

  enum status: { pending: 'pending', active: 'active', deactivated: 'deactivated' }

  scope :ordered, -> { order(created_at: :desc) }

  def initials
    name.split.map(&:first).join
  end

  def active_for_authentication?
    super && !deactivated?
  end

  def inactive_message
    deactivated? ? :deactivated : super
  end

  def activate!
    update!(status: :active)
  end

  def deactivate!
    return unless active? || reactivated?

    update!(status: :deactivated, deactivated_at: Time.current)
  end

  def reactivate!(activator:)
    return unless deactivated?

    update!(status: :pending, reactivated_by: activator, reactivated_at: Time.current)
  end

  def enable_two_factor!
    super && activate!
  end

  def reset_two_factor!
    super && pending!
  end

  def remove!
    return unless pending?

    if reactivated?
      deactivate!
    else
      destroy
    end
  end

  private

  def reactivated?
    reactivated_at.present?
  end

  def pending!
    return if pending?

    update!(status: :pending)
  end
end
