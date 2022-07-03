# == Schema Information
#
# Table name: points
#
#  id         :bigint           not null, primary key
#  discord_id :string           not null
#  points     :integer          default(0), not null
#
FactoryBot.define do
  factory :point do
    sequence :discord_id do |n|
      n
    end
  end
end
