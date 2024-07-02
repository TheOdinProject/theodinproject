class AdminV2::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  def create
    self.resource = invite_resource

    respond_to do |format|
      if resource.errors.empty?
        @invited_admin_user = resource
        flash.now[:notice] = "Invitation sent to #{resource.email}"
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def after_accept_path_for(_resource)
    admin_v2_dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[name email])
  end
end
