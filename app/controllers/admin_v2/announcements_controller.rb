module AdminV2
  class AnnouncementsController < AdminV2::BaseController
    def index
      @pagy, @announcements = pagy(Announcement.for_status(params.fetch(:status, :active)).ordered_by_recent, items: 20)
    end
  end
end
