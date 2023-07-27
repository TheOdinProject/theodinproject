FactoryBot.define do
  factory :flag do
    flagger { association :user }
    project_submission
    reason { 3 }
    extra { "It's offensive" }
  end
end
