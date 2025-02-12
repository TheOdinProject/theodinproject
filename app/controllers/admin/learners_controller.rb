module Admin
  class LearnersController < Admin::BaseController
    before_action :authorize_admin, only: %i[destroy]

    def index
      if params[:search_term].present?
        @pagy, @learners = pagy(User.search_by(params[:search_term]), items: 20)
      else
        @pagy, @learners = pagy(User.all, items: 20)
      end
    end

    def show
      @learner = User.find(params[:id])
    end

    def destroy
      @learner = User.find(params[:id])

      current_admin_user.create_activity(
        key: 'admin_user.deleted_learner',
        owner: current_admin_user,
        params: { email: @learner.email }
      )

      @learner.destroy
      redirect_to admin_learners_path, notice: 'Learner deleted'
    end

    private

    def authorize_admin
      return if AdminUserPolicy.new(current_admin_user).delete_learner?

      redirect_to admin_learners_path, alert: 'You are not authorized to perform this action'
    end
  end
end
