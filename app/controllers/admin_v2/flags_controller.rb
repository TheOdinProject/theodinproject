module AdminV2
  class FlagsController < AdminV2::BaseController
    def index
      @pagy, @flags = pagy(Flag.by_status(params.fetch(:status, 'active')).ordered_by_most_recent, items: 20)
    end

    def show
      @flag = Flag.find(params[:id])
    end

    def update
      @flag = Flag.find(params[:id])
      flash[:notice] = "Flag #{params[:action_taken]}"
      redirect_to admin_v2_flag_path(@flag)
    end
  end
end
