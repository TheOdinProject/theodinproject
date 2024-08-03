module AdminV2
  class TeamMembers::ReactivationController < AdminV2::BaseController
    before_action :authorize_admin
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def update
      team_member = AdminUser.find(params[:team_member_id])

      team_member.reactivate!
      team_member.reset_two_factor!
      team_member.invite!(current_admin_user)

      redirect_to admin_v2_team_path, notice: "#{team_member.name} reactivated"
    end

    private

    def record_not_found
      redirect_to admin_v2_team_path, alert: 'Team member not found'
    end

    def authorize_admin
      return if AdminUserPolicy.new(current_admin_user).reactivate?

      redirect_to admin_v2_team_path, alert: 'You are not authorized to perform this action'
    end
  end
end
