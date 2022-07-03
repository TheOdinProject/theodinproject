# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  recipient_type :string           not null
#  recipient_id   :bigint           not null
#  type           :string           not null
#  params         :jsonb
#  read_at        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  url            :string           not null
#  message        :text             not null
#  title          :string           not null
#
FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user
    type { '' }
    params { '' }
    read_at { Time.zone.now }
    url { '' }
    message { '' }
    title { '' }
  end
end
