# == Schema Information
#
# Table name: path_prerequisites
#
#  id              :bigint           not null, primary key
#  path_id         :bigint           not null
#  prerequisite_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :path_prerequisite do
    association :path, factory: :path
    association :prerequisite, factory: :path
  end
end
