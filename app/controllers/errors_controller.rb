class ErrorsController < ActionController::Base # rubocop:disable Rails/ApplicationController
  def unprocessable_entity
    render status: :unprocessable_entity
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
