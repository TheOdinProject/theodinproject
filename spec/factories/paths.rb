# == Schema Information
#
# Table name: paths
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :string
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  slug            :string
#  default_path    :boolean          default(FALSE), not null
#  identifier_uuid :string           default(""), not null
#  short_title     :string
#
FactoryBot.define do
  factory :path do
    sequence(:title) { |n| "test path#{n}" }
    sequence(:position) { |n| n }
    description { 'A Path' }
    identifier_uuid { SecureRandom.uuid }
  end
end
