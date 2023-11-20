FactoryBot.define do
  factory :flag do
    flagger { association :user }
    project_submission
    reason { :spam }
    extra { "It's offensive" }
  end
end
