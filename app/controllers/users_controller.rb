class UsersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource only: %i[edit update update_onboarding_steps]

  def show
    @courses = decorated_path_courses
  end

  def update
    current_user.update!(user_params)
    render json: current_user
  end

  def update_onboarding_steps
    current_user.update_onboarding(user_params[:community_onboarding_steps].to_h)
    redirect_to dashboard_path
  end

  private

  def decorated_path_courses
    current_user.path.courses.map do |course|
      CourseDecorator.new(course)
    end
  end

  # rubocop: disable Metrics/MethodLength
  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation,
      :learning_goal,
      :uid,
      :provider,
      :path_id,
      community_onboarding_steps: %i[step_one step_two step_three step_four]
    )
  end
  # rubocop: enable Metrics/MethodLength
end
