module AdminV2
  class TeamMembers::ReactivationController < AdminV2::BaseController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def update
      team_member = AdminUser.find(params[:team_member_id])

      team_member.reactivate!(activator: current_admin_user)
      team_member.invite!(current_admin_user)

      redirect_to admin_v2_team_path, notice: "#{team_member.name} reactivated"
    end

    private

    def record_not_found
      redirect_to admin_v2_team_path, alert: 'Team member not found'
    end
  end
end
