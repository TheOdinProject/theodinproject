module AdminV2
  class TeamMembersController < AdminV2::BaseController
    def index
      @pending_team_members = AdminUser.awaiting_activation.ordered
      @active_team_members = AdminUser.activated.ordered
      @deactivated_team_members = AdminUser.deactivated.ordered
    end

    def destroy # rubocop:disable Metrics/MethodLength
      team_member = AdminUser.find(params[:id])

      if team_member.awaiting_activation?
        team_member.create_activity(
          key: 'admin_user.removed',
          owner: current_admin_user,
          params: { name: team_member.name }
        )

        team_member.remove!
        redirect_to admin_v2_team_path, notice: "Removed #{team_member.name} from the team"
      else
        redirect_to admin_v2_team_path, alert: 'Only pending team members can be removed'
      end
    end
  end
end
