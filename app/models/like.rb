class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
  validates :likeable_type, presence: true

  scope :created_today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }
end
