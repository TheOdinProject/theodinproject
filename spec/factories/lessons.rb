# == Schema Information
#
# Table name: lessons
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  github_path         :string(255)
#  position            :integer          not null
#  description         :text
#  is_project          :boolean          default(FALSE)
#  section_id          :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content             :text
#  slug                :string
#  accepts_submission  :boolean          default(FALSE), not null
#  has_live_preview    :boolean          default(FALSE), not null
#  choose_path_lesson  :boolean          default(FALSE), not null
#  identifier_uuid     :string           default(""), not null
#  course_id           :bigint
#  installation_lesson :boolean          default(FALSE)
#
FactoryBot.define do
  factory :lesson do
    section
    sequence(:title) { |n| "test lesson#{n}" }
    sequence(:position) { |n| n }
    github_path { '/lesson_course/lesson_title.md' }
    content { 'content' }
    identifier_uuid { SecureRandom.uuid }

    trait :project do
      is_project { true }
      accepts_submission { true }
      has_live_preview { true }
    end
  end
end
