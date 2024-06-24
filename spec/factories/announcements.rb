FactoryBot.define do
  factory :announcement do
    message { 'a message for all users' }
    expires_at { 1.day.from_now }
    user
    learn_more_url { 'https://example.com' }

    trait :without_validations do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
