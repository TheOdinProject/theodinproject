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
class Flag < ApplicationRecord
  belongs_to :flagger, class_name: 'User'
  belongs_to :project_submission

  validates :reason, presence: true

  enum status: { active: 0, resolved: 1 }
  enum taken_action: { pending: 0, dismiss: 1, ban: 2, removed_project_submission: 3, notified_user: 4 }
end
