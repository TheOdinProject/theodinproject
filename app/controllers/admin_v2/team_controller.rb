module AdminV2
  class TeamController < AdminV2::BaseController
    def show
      @pending_team_members = AdminUser.pending.ordered
      @active_team_members = AdminUser.active.ordered
      @deactivated_team_members = AdminUser.deactivated.ordered
    end
  end
end
