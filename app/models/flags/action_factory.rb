class Flags::ActionFactory
  def initialize(action)
    @action = action.to_sym
  end

  def self.for(action)
    new(action).action
  end

  def action
    {
      dismiss: Flags::Actions::Dismiss,
      ban: Flags::Actions::Ban,
      removed_project_submission: Flags::Actions::RemoveProjectSubmission,
      notified_user: Flags::Actions::NotifyUser
    }.fetch(@action, Flags::Actions::NullAction)
  end
end
