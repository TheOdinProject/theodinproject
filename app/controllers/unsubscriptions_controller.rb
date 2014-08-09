class UnsubscriptionsController < ApplicationController

  def email_unsubscribe
    @categories = EmailCampaignCategory.list
  end

  def create
    @user = User.find_by_email(params[:email_address])
    if @user == nil
      flash[:error] = "Email address is invalid"
      redirect_to(:email_unsubscribe) and return
    end    
    @categories = params[:categories]
    if @categories.include?("unsubscribe_all")
      @user.unsubscribe_all
      redirect_to(confirm_unsubscription_path) and return
    end
    Unsubscription.unsubscribe(@user, @categories)
    redirect_to confirm_unsubscription_path
  end

  def confirm_unsubscription
  end
end
