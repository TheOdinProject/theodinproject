module AdminV2
  class TeamMembers::RoleController < AdminV2::BaseController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def edit
      @team_member = AdminUser.find(params[:team_member_id])
    end

    def update
      @team_member = AdminUser.find(params[:team_member_id])

      respond_to do |format|
        if @team_member.update(admin_user_params)
          flash.now[:notice] = "#{@team_member.name} role updated"
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def admin_user_params
      params.require(:admin_user).permit(:role)
    end

    def record_not_found
      redirect_to admin_v2_team_path, alert: 'Team member not found'
    end
  end
end
