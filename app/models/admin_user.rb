class AdminUser < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :trackable, :timeoutable, :validatable,
         password_length: 8..128

  belongs_to :deactivated_by, class_name: 'AdminUser', optional: true

  validates :name, presence: true, uniqueness: true

  enum status: { pending: 'pending', active: 'active', deactivated: 'deactivated' }

  after_invitation_accepted :activate!

  def initials
    name.split.map(&:first).join
  end

  def active_for_authentication?
    super && !deactivated?
  end

  def inactive_message
    deactivated? ? :deactivated : super
  end

  def deactivate!(deactivator:)
    return unless active?

    update!(status: :deactivated, deactivated_by: deactivator, deactivated_at: Time.current)
  end

  private

  def activate!
    update!(status: :active)
  end
end
