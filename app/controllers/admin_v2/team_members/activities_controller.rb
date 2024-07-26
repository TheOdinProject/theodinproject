module AdminV2
  class TeamMembers::ActivitiesController < AdminV2::BaseController
    def index
      @activities = PublicActivity::Activity.where(trackable_type: 'AdminUser').order(created_at: :desc)
    end
  end
end
