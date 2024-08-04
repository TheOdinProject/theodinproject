# rubocop:disable Rails/ApplicationController
module Admin
  class BaseController < ActionController::Base
    helper(Classy::Yaml::Helpers)
    include Pagy::Backend
    include CurrentTheme

    before_action :authenticate_admin_user!
    before_action :ensure_two_factor_enabled, if: :current_admin_user
    before_action :set_current_admin_user

    private

    def ensure_two_factor_enabled
      return unless two_factor_setup_required? || devise_controller?

      redirect_to(
        new_admin_two_factor_authentication_path,
        alert: 'Please enable two factor authentication before continuing.',
      )
    end

    def two_factor_setup_required?
      current_admin_user.awaiting_activation? && !current_admin_user.two_factor_enabled?
    end

    def set_current_admin_user
      Current.admin_user = current_admin_user
    end
  end
end
# rubocop:enable Rails/ApplicationController
