module Admin
  class DashboardController < Admin::BaseController
    def show
      @active_flags_count = Flag.count_for(:active)
      @active_announcements_count = Announcement.active.count
    end
  end
end
