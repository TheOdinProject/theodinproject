# == Schema Information
#
# Table name: flags
#
#  id                    :bigint           not null, primary key
#  flagger_id            :integer          not null
#  project_submission_id :bigint           not null
#  reason                :text             default(""), not null
#  status                :integer          default("active"), not null
#  taken_action          :integer          default("pending"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  resolved_by_id        :integer
#
FactoryBot.define do
  factory :flag do
    flagger { build(:user) }
    project_submission
    reason { "It's offensive" }
  end
end
