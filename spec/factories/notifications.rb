FactoryBot.define do
  factory :notification do
    recipient factory: :user
    type { '' }
    params { '' }
    read_at { Time.zone.now }
    url { '' }
    message { '' }
    title { '' }
  end
end
