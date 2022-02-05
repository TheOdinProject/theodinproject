class CommunityController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.community_onboarded?
      redirect_to ODIN_CHAT_URL
    else
      redirect_to dashboard_path,
                  alert: 'To join our community, you must complete the Discord community onboarding below.'
    end
  end
end
