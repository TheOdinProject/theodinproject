module Admin
  class TeamMembers::DeactivationController < Admin::BaseController
    before_action :authorize_admin

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def update
      team_member = AdminUser.find(params[:team_member_id])
      team_member.deactivate!

      redirect_to admin_team_path, notice: "#{team_member.name} deactivated"
    end

    private

    def record_not_found
      redirect_to admin_team_path, alert: 'Team member not found'
    end

    def authorize_admin
      return if AdminUserPolicy.new(current_admin_user).deactivate?

      redirect_to admin_team_path, alert: 'You are not authorized to perform this action'
    end
  end
end
