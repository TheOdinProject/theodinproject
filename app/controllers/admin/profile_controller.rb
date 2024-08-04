module Admin
  class ProfileController < Admin::BaseController
    def edit
      # Use a separate admin user instance to avoid morphing current admin when valildation fails
      @admin_user = AdminUser.find(current_admin_user.id)
    end

    def update
      @admin_user = AdminUser.find(current_admin_user.id)

      if @admin_user.update(profile_params)
        redirect_to edit_admin_profile_path, notice: 'Account updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def profile_params
      params.require(:profile).permit(:email, :name)
    end
  end
end
