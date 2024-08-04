module Admin
  class TeamMembers::ResendInvitationController < Admin::BaseController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create # rubocop:disable Metrics/MethodLength
      team_member = AdminUser.find(params[:team_member_id])

      if team_member.awaiting_activation?
        team_member.invite!(current_admin_user)

        team_member.create_activity(
          key: 'admin_user.reinvited',
          owner: current_admin_user,
          params: { name: team_member.name }
        )

        redirect_to admin_team_path, notice: "Invite sent to #{team_member.name}"
      else
        redirect_to admin_team_path, alert: "#{team_member.name} has already accepted the invitation"
      end
    end

    private

    def record_not_found
      redirect_to admin_team_path, alert: 'Team member not found'
    end
  end
end
