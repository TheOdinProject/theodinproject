module AdminV2
  class TeamMembersController < AdminV2::BaseController
    def destroy # rubocop:disable Metrics/MethodLength
      team_member = AdminUser.find(params[:id])

      if team_member.pending?
        team_member.create_activity(
          key: 'admin_user.removed',
          owner: current_admin_user,
          params: { name: team_member.name }
        )

        team_member.remove!
        redirect_to admin_v2_team_path, notice: "#{team_member.name} removed from the team"
      else
        redirect_to admin_v2_team_path, alert: 'Only pending team members can be removed'
      end
    end
  end
end
