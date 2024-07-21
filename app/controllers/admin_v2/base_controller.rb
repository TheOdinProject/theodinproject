# rubocop:disable Rails/ApplicationController
module AdminV2
  class BaseController < ActionController::Base
    helper(Classy::Yaml::Helpers)
    include Pagy::Backend
    include CurrentTheme

    before_action :authenticate_admin_user!
    before_action :ensure_two_factor_enabled, if: :current_admin_user

    private

    def ensure_two_factor_enabled
      return unless two_factor_setup_required? || devise_controller?

      redirect_to(
        new_admin_v2_two_factor_authentication_path,
        alert: 'Please enable two factor authentication before continuing.',
      )
    end

    def two_factor_setup_required?
      current_admin_user.pending? && !current_admin_user.two_factor_enabled?
    end
  end
end
# rubocop:enable Rails/ApplicationController
