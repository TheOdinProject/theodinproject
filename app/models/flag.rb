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
  belongs_to :resolved_by, class_name: 'AdminUser', optional: true

  validates :reason, presence: true
  validates :extra, presence: true, if: -> { reason == 'other' }
  validates :resolved_by_id, presence: true, if: -> { status == 'resolved' }

  enum reason: REASONS.each_with_object({}) { |reason, hash| hash[reason.name] = reason.value }
  enum status: { active: 0, resolved: 1 }
  enum action_taken: { pending: 0, dismiss: 1, ban: 2, removed_project_submission: 3, notified_user: 4 }

  scope :by_status, ->(status) { where(status:) }
  scope :count_for, ->(status) { by_status(status).count }
  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  def project_submission_owner
    project_submission.user
  end

  def resolve(action_taken:, resolved_by:)
    update(
      status: :resolved,
      action_taken:,
      resolved_by:
    )
  end

  def action_taken_value
    Flags::Action.for(action_taken)
  end
end
