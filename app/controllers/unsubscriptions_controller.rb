class UnsubscriptionsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]
  before_filter :confirm_categories_exist

  def email_unsubscribe
    @categories = EmailCampaignCategory.list
  end

  def create
    @user = User.find_by_email(params[:email_address])
    @categories = params[:categories]
    verify_user; return if performed?
    confirm_categories_are_checked; return if performed?
    create_unsubscriptions
    check_unsubscribe_all; return if performed?
    redirect_to courses_path, notice: "Subscription preferences have been updated for
    #{@user.email}.  Login to view and update preferences from your profile page at any time."
  end

  def edit
    @categories = EmailCampaignCategory.list
    @currently_unsubscribed = Unsubscription.where(
      user_id: current_user.id).pluck(:email_campaign_category_id)
    render :email_preferences
  end

  def update
    @categories = params[:categories]
    @user = current_user
    # Remove all unsubscriptions and clear flag if user clears boxes
    if @categories == nil
      remove_all_unsubscriptions and return
    end
    update_subscriptions
    redirect_to email_preferences_path, notice: "Email preferences have been successfully 
    updated"
  end

  protected

  def confirm_categories_exist
    if EmailCampaignCategory.count == 0
      flash[:error] = "We're sorry. Something went wrong. Please email us at
      contact@theodinproject.com for assistance"
      redirect_to(courses_path) and return
    end
  end

  def verify_user
    if @user == nil
      flash[:error] = "Email address is invalid"
      redirect_to(:email_unsubscribe) and return
    end  
  end

  def confirm_categories_are_checked
    if @categories == nil
      redirect_to(courses_path, 
        notice: "Login to view and update preferences from your profile page at any time.") and return
    end
  end

  def create_unsubscriptions
    @categories.values.each do |c|
      Unsubscription.create(user_id: @user.id, email_campaign_category_id: c)
    end
  end

  def check_unsubscribe_all
    if @categories.include?("All")
      @user.update_column(:unsubscribe_all, true)
      redirect_to(courses_path, notice: "Email address #{@user.email} has been 
        unsubscribed from all categories.  Login to view and update preferences
        from your profile page at any time.") and return
    end
  end

  def remove_all_unsubscriptions
    current_user.unsubscriptions.destroy_all
    current_user.update_column(:unsubscribe_all, false)
    redirect_to(email_preferences_path, notice: "Thanks for opting in to receive
      emails from The Odin Project")
  end

  def update_subscriptions
    # Remove any unsubscriptions for unchecked boxes
    remove_canceled_unsubscriptions
    # Set or remove unsubscribe_all flag
    update_unsubscribe_all
    # Create unsubscriptions for any checked boxes
    create_unsubscriptions
  end

  def remove_canceled_unsubscriptions
    current_user.unsubscriptions.each do |u|
      unless @categories.values.include?(u.email_campaign_category_id)
        u.delete
      end      
    end
  end

  def update_unsubscribe_all
    if @categories.keys.include?("All")
      current_user.update_column(:unsubscribe_all, true)
    else
      current_user.update_column(:unsubscribe_all, false)
    end
  end
end
