module AdminV2
  class TwoFactorAuthenticationController < AdminV2::BaseController
    skip_before_action :ensure_two_factor_enabled

    def new
      if current_admin_user.two_factor_enabled?
        redirect_to admin_v2_dashboard_path, status: :see_other, alert: 'Two factor authentication is already enabled.'
        return
      end

      current_admin_user.generate_two_factor_secret_if_missing!
    end

    def create
      if current_admin_user.validate_and_consume_otp!(two_factor_params[:otp_code])
        current_admin_user.enable_two_factor!

        redirect_to admin_v2_dashboard_path, notice: 'Successfully enabled two factor authentication'
      else
        flash.now[:alert] = 'Incorrect Code'
        render :new, status: :unprocessable_entity
      end
    end

    private

    def two_factor_params
      params.require(:two_fa).permit(:otp_code)
    end
  end
end
