module AdminV2
  class TeamController < AdminV2::BaseController
    def show
      @pending_team_members = AdminUser.pending
      @active_team_members = AdminUser.active
    end
  end
end
