FactoryBot.define do
  factory :like do
    user
    likeable factory: :project_submission
  end
end
