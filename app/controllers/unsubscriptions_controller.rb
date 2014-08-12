class UnsubscriptionsController < ApplicationController
  before_filter :authenticate_request, only: [:edit, :update]

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
    Unsubscription.unsubscribe(@user, @categories)
    if @categories.include?("All")
      @user.unsubscribe_all
      redirect_to(courses_path, notice: "Email address #{@user.email} has been 
        unsubscribed from all categories.  Login to view and update preferences
        from your profile page at any time.") and return
    end
    redirect_to courses_path, notice: "Subscription preferences have been updated for
    #{@user.email}.  Login to view and update preferences from your profile page at any time."
  end

  def edit
    @categories = EmailCampaignCategory.list
    @currently_unsubscribed = Unsubscription.category_names(current_user.unsubscriptions)
    render :email_preferences
  end

  def update
    currently_unsubscribed = Unsubscription.category_names(current_user.unsubscriptions)
    puts "\n\n\n\n\n\n\n\n\n\n"
    puts currently_unsubscribed
    categories = params[:categories]
    currently_unsubscribed.each do |c|
      if !categories.include?(Unsubscription.category_names(c))
        Unsubscription.destroy(c)
      end
    end
    Unsubscription.unsubscribe(current_user, categories)
    redirect_to email_preferences_path, notice: "Email preferences have been successfully 
    updated"
  end


  protected

  def authenticate_request
    unless user_signed_in?
      render :nothing => true, :status => 401 # unauthorized
    end
  end


end
