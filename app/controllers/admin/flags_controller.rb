module Admin
  class FlagsController < Admin::BaseController
    def index
      @pagy, @flags = pagy(Flag.by_status(params.fetch(:status, 'active')).ordered_by_most_recent, items: 20)
    end

    def show
      @flag = Flag.find(params[:id])
    end

    def update
      @flag = Flag.find(params[:id])
      action = ::Flags::ActionFactory.for(params[:action_taken])
      result = action.perform(flag: @flag, admin_user: current_admin_user)

      if result.success?
        redirect_to admin_flag_path(@flag), notice: result.message
      else
        redirect_to admin_flag_path(@flag), alert: result.message
      end
    end
  end
end
