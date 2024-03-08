class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :trackable, :timeoutable, :validatable

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }

  def initials
    name.split.map(&:first).join
  end
end
