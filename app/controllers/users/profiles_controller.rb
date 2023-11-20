module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def edit; end

    def update
      if current_user.update(user_params)
        redirect_to edit_users_profile_path, notice: 'Your account has been updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :learning_goal)
    end
  end
end
