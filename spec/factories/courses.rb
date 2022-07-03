# == Schema Information
#
# Table name: courses
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position         :integer          not null
#  slug             :string
#  identifier_uuid  :string           default(""), not null
#  path_id          :integer
#  show_on_homepage :boolean          default(FALSE), not null
#  badge_uri        :string           not null
#
FactoryBot.define do
  factory :course do
    path
    sequence(:title) { |n| "test course#{n}" }
    sequence(:position) { |n| n }
    identifier_uuid { SecureRandom.uuid }
    badge_uri { 'badge-foundations.svg' }
  end
end
