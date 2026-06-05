FactoryBot.define do
  factory :notification do
    recipient factory: :user
    read_at { Time.zone.now }
    url { '' }
    message { '' }
    title { '' }
  end
end
