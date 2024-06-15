class Flags::Actions::RemoveProjectSubmission < Flags::Actions::Action
  def perform
    ActiveRecord::Base.transaction do
      flag.project_submission.discard
      flag.resolve(action_taken: :removed_project_submission, resolved_by: admin_user)
    end

    if flag.resolved?
      Result.new(success: true,  message: 'Project submission removed')
    else
      Result.new(success: false, message: flag.errors.full_messages.join(', '))
    end
  end
end
