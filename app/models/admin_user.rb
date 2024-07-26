class AdminUser < ApplicationRecord
  include TwoFactorAuthenticatable
  include PublicActivity::Common
  include AASM

  devise :two_factor_authenticatable
  devise :invitable, :recoverable, :trackable, :timeoutable, :validatable,
         password_length: 8..128

  belongs_to :reactivated_by, class_name: 'AdminUser', optional: true

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(created_at: :desc) }
  scope :awaiting_activation, -> { pending.or(pending_reactivation) }

  enum status: {
    pending: 'pending',
    activated: 'activated',
    deactivated: 'deactivated',
    pending_reactivation: 'pending_reactivation'
  }

  aasm column: :status, enum: true, timestamps: true do
    state :pending, initial: true
    state :activated, :deactivated, :pending_reactivation

    after_all_transitions :log_status_change

    event :activate do
      transitions from: %i[pending pending_reactivation], to: :activated
    end

    event :deactivate do
      transitions from: %i[activated pending_reactivation], to: :deactivated
    end

    event :reactivate do
      transitions from: :deactivated, to: :pending_reactivation, after: :set_reactivated_at!
    end
  end

  def awaiting_activation?
    pending? || pending_reactivation?
  end

  def initials
    name.split.map(&:first).join
  end

  def active_for_authentication?
    super && !deactivated?
  end

  def inactive_message
    deactivated? ? :deactivated : super
  end

  def enable_two_factor!
    super && activate!
  end

  def remove!
    return unless awaiting_activation?

    if pending_reactivation?
      deactivate!
    else
      destroy!
    end
  end

  private

  def log_status_change
    create_activity(key: "admin_user.#{aasm.to_state}", owner: Current.admin_user)
  end

  def set_reactivated_at!
    update!(reactivated_at: Time.current)
  end
end
