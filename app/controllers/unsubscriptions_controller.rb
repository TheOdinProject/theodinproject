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
      redirect_to(courses_path, notice: "Email address #{@user.email} has been 
        unsubscribed from all categories.  Login to view and update preferences
        from your profile page at any time.") and return
    end
    Unsubscription.unsubscribe(@user, @categories)
    # redirect_to confirm_unsubscription_path(params[:email_address] => @user.email, 
    #   params[:list] => @categories)
    redirect_to courses_path, notice: "Subscription preferences have been updated for
    #{@user.email}.  Login to view and update preferences from your profile page at any time."
  end

end
