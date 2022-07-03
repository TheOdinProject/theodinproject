# == Schema Information
#
# Table name: lesson_completions
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  user_id                :integer
#  created_at             :datetime
#  updated_at             :datetime
#  lesson_identifier_uuid :string           default(""), not null
#  course_id              :integer
#  path_id                :integer
#
FactoryBot.define do
  factory :lesson_completion do
    association :user, factory: :user
    association :lesson, factory: :lesson
  end
end
