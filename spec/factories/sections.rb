# == Schema Information
#
# Table name: sections
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  position        :integer          not null
#  course_id       :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  description     :text
#  identifier_uuid :string           default(""), not null
#
FactoryBot.define do
  factory :section do
    course
    sequence(:title) { |n| "test section#{n}" }
    sequence(:position) { |n| n }
    identifier_uuid { SecureRandom.uuid }
  end
end
