module AdminV2
  class DashboardController < AdminV2::BaseController
    def show
      @active_flags_count = Flag.count_for(:active)
    end
  end
end
