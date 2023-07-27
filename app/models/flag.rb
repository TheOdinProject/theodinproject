class Flag < ApplicationRecord
  belongs_to :flagger, class_name: 'User'
  belongs_to :project_submission

  validates :reason, presence: true

  enum reason: { broken: 0, insecure: 1, spam: 2, inappropriate: 3, other: 4 }
  enum status: { active: 0, resolved: 1 }
  enum taken_action: { pending: 0, dismiss: 1, ban: 2, removed_project_submission: 3, notified_user: 4 }
end
