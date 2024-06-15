class Flags::Actions::Ban < Flags::Actions::Action
  def perform
    flag.project_submission_owner.ban!
    flag.resolve(action_taken: :ban, resolved_by: admin_user)

    if flag.resolved?
      Result.new(success: true, message: 'Project submission owner has been banned')
    else
      Result.new(success: false, message: flag.errors.full_messages.join(', '))
    end
  end
end
