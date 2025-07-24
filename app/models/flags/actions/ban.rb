class Flags::Actions::Ban < Flags::Actions::Base
  def perform # rubocop:disable Metrics/AbcSize
    flag.project_submission_owner.ban!
    flag.resolve(action_taken: :ban, resolved_by: admin_user)

    if flag.resolved?
      send_email(flag.project_submission_owner)
      Result.new(success: true, message: 'Project submission owner has been banned')
    else
      Result.new(success: false, message: flag.errors.full_messages.join(', '))
    end
  end

  private

  def send_email(project_submission_owner)
    UserMailer.send_ban_email_to(project_submission_owner).deliver_later(project_submission_owner)
  end
end
