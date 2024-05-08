FactoryBot.define do
  factory :flag do
    flagger { association :user }
    project_submission
    reason { :spam }
    extra { "It's offensive" }

    trait :active do
      status { :active }
    end

    trait :resolved do
      status { :resolved }
    end
  end
end
