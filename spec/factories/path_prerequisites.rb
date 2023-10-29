FactoryBot.define do
  factory :path_prerequisite do
    path
    prerequisite factory: :path
  end
end
