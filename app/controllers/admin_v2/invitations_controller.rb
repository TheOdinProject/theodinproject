class AdminV2::InvitationsController < Devise::InvitationsController
  before_action :authorize_admin, only: %i[new create] # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :configure_permitted_parameters
  after_action :create_invited_activity, only: :create

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
    devise_parameter_sanitizer.permit(:invite, keys: %i[name email role])
  end

  def create_invited_activity
    return unless @invited_admin_user

    @invited_admin_user.create_activity(
      key: 'admin_user.invited',
      owner: current_admin_user,
      params: { name: @invited_admin_user.name }
    )
  end

  def authorize_admin
    return if AdminUserPolicy.new(current_admin_user).invite?

    redirect_to admin_v2_team_path, alert: 'You are not authorized to perform this action'
  end
end
