class UnsubscriptionsController < ApplicationController

  def email_unsubscribe
    @categories = EmailCampaignCategory.list
  end

  def create
  end

  def confirm_unsubscription
  end
end
