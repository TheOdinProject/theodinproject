module Admin
  class Profile::PasswordController < Admin::BaseController
    def update
      @admin_user = AdminUser.find(current_admin_user.id)

      if @admin_user.update_with_password(password_params)
        # Sign in the user by passing validation in case their password changed
        bypass_sign_in(@admin_user)
        redirect_to edit_admin_profile_path, notice: 'Password updated'
      else
        render 'admin/profile/edit', status: :unprocessable_entity
      end
    end

    private

    def password_params
      params.require(:admin_user).permit(:password, :password_confirmation, :current_password)
    end
  end
end
