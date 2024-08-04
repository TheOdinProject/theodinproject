module Admin
  class TeamMembers::ActivitiesController < Admin::BaseController
    def index
      @activities = PublicActivity::Activity.where(trackable_type: 'AdminUser').order(created_at: :desc)
    end
  end
end
