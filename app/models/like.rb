class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
  validates :likeable_type, presence: true

  scope :liked_on, ->(date) { where(created_at: date.all_day) }
end
