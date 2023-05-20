FactoryBot.define do
  factory :lesson_completion do
    association :user
    association :lesson
  end
end
