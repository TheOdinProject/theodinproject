# == Schema Information
#
# Table name: points
#
#  id         :bigint           not null, primary key
#  discord_id :string           not null
#  points     :integer          default(0), not null
#
class Point < ApplicationRecord
  LOWEST_ALLOWED_INCREMENT = 1
  MAX_ALLOWED_INCREMENT = 5

  validates :discord_id, presence: true, uniqueness: true

  def increment_points_by(value)
    return unless value.between?(LOWEST_ALLOWED_INCREMENT, MAX_ALLOWED_INCREMENT)

    update!(points: self.points += value)
  end
end
