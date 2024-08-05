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
      resolved_by { association :admin_user }
    end
  end
end
