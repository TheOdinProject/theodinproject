class Flag < ApplicationRecord
  Reason = Data.define(:name, :description, :value)

  REASONS = [
    { name: :broken, description: 'Link does not work', value: 10 },
    { name: :insecure, description: 'Link is not secure or safe', value: 20 },
    { name: :spam, description: 'Spam or misleading', value: 30 },
    { name: :inappropriate, description: 'Inappropriate imagery or language', value: 40 },
    { name: :other, description: 'Other', value: 50 }
  ].map { |reason| Reason.new(**reason) }

  belongs_to :flagger, class_name: 'User'
  belongs_to :project_submission

  validates :reason, presence: true
  validates :extra, presence: true, if: -> { reason == 'other' }

  enum reason: REASONS.each_with_object({}) { |reason, hash| hash[reason.name] = reason.value }
  enum status: { active: 0, resolved: 1 }
  enum taken_action: { pending: 0, dismiss: 1, ban: 2, removed_project_submission: 3, notified_user: 4 }
end
