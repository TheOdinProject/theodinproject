FactoryBot.define do
  factory :flag do
    flagger { association :user }
    project_submission
    reason { "It's offensive" }
  end
end
