FactoryBot.define do
  factory :lesson_preview do
    sequence(:content) { |n| "lesson preview #{n}" }
  end
end
