class Flags::Actions::Dismiss < Flags::Actions::Base
  def perform
    flag.resolve(action_taken: :dismiss, resolved_by: admin_user)

    if flag.resolved?
      Result.new(success: true, message: 'Flag dismissed')
    else
      Result.new(success: false, message: flag.errors.full_messages.join(', '))
    end
  end
end
