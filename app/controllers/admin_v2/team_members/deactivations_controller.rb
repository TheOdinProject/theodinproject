module AdminV2
  class TeamMembers::DeactivationsController < AdminV2::BaseController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
      team_member = AdminUser.find(params[:team_member_id])

      team_member.deactivate!(deactivator: current_admin_user)
      redirect_to admin_v2_team_path, notice: "#{team_member.name} deactivated"
    end

    private

    def record_not_found
      redirect_to admin_v2_team_path, alert: 'Team member not found'
    end
  end
end
