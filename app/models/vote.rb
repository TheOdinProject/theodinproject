# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_type :string
#  votable_id   :integer
#  voter_type   :string
#  voter_id     :integer
#  vote_flag    :boolean
#  vote_scope   :string
#  vote_weight  :integer
#  created_at   :datetime
#  updated_at   :datetime
#
class Vote < ApplicationRecord
  scope :created_today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }
end
