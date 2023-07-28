FactoryBot.define do
  factory :lesson do
    section
    sequence(:title) { |n| "test lesson#{n}" }
    sequence(:position) { |n| n }
    github_path { '/lesson_course/lesson_title.md' }
    identifier_uuid { SecureRandom.uuid }

    trait :project do
      is_project { true }
      accepts_submission { true }
      previewable { true }
    end

    trait :complete do
      after(:create) do |lesson|
        lesson.completed = true
      end
    end

    trait :incomplete do
      after(:create) do |lesson|
        lesson.completed = false
      end
    end

    after(:create) do |lesson|
      if lesson.content.blank?
        create(:content, lesson:)
        lesson.reload
      end
    end
  end
end
