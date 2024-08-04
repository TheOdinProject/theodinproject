module Admin
  class TeamMembers::TwoFactorResetController < Admin::BaseController
    before_action :authorize_admin
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def update
      team_member = AdminUser.find(params[:team_member_id])

      team_member.reset_two_factor!
      team_member.pending!
      team_member.create_activity(key: 'admin_user.two_factor_reset', owner: current_admin_user)
      redirect_to admin_team_path, notice: "#{team_member.name} two factor reset"
    end

    private

    def record_not_found
      redirect_to admin_team_path, alert: 'Team member not found'
    end

    def authorize_admin
      return if AdminUserPolicy.new(current_admin_user).reset_2fa?

      redirect_to admin_team_path, alert: 'You are not authorized to perform this action'
    end
  end
end
