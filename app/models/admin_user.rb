class AdminUser < ApplicationRecord
  include TwoFactorAuthenticatable

  devise :two_factor_authenticatable
  devise :invitable, :recoverable, :trackable, :timeoutable, :validatable,
         password_length: 8..128

  belongs_to :deactivated_by, class_name: 'AdminUser', optional: true
  belongs_to :reactivated_by, class_name: 'AdminUser', optional: true

  validates :name, presence: true, uniqueness: true

  enum status: { pending: 'pending', active: 'active', deactivated: 'deactivated' }

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

  def deactivate!(deactivator:)
    return unless active?

    update!(status: :deactivated, deactivated_by: deactivator, deactivated_at: Time.current)
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

  private

  def pending!
    return if pending?

    update!(status: :pending)
  end
end
