# rubocop:disable Rails/ApplicationController
module AdminV2
  class BaseController < ActionController::Base
    helper(Classy::Yaml::Helpers)
    include Pagy::Backend
    include CurrentTheme

    before_action :authenticate_admin_user!
  end
end
# rubocop:enable Rails/ApplicationController
