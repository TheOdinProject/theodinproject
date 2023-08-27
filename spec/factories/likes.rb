FactoryBot.define do
  factory :like do
    user
    association :likeable, factory: :project_submission
  end
end
