module Admin
  class DashboardController < Admin::BaseController
    def show
      @active_flags_count = Flag.count_for(:active)
    end
  end
end
