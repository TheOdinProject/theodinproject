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
FactoryBot.define do
  factory :announcement do
    message { 'a message for all users' }
    expires_at { 1.day.from_now }
    user { create(:user) }
  end
end
