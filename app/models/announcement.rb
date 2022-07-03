# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message    :string(255)
#  expires_at :datetime         not null
#  user_id    :bigint
#
class Announcement < ApplicationRecord
  validates :message, presence: true
  validates :expires_at, presence: true

  scope :unexpired_messages, -> { where(expires_at: Time.zone.now..Float::INFINITY).order(created_at: :desc) }
  scope :showable_messages, ->(disabled_ids) { unexpired_messages.where.not(id: disabled_ids) }

  belongs_to :user, optional: true
end
