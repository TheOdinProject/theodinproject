class AdminUser < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :trackable, :timeoutable, :validatable,
         password_length: 8..128

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  enum status: { pending: 'pending', active: 'active', deactivated: 'deactivated' }

  after_invitation_accepted :activate!

  def initials
    name.split.map(&:first).join
  end

  private

  def activate!
    update!(status: :active)
  end
end
