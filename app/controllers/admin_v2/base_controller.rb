# rubocop:disable Rails/ApplicationController
module AdminV2
  class BaseController < ActionController::Base
    before_action :authenticate_admin_user!
  end
end
# rubocop:enable Rails/ApplicationController
