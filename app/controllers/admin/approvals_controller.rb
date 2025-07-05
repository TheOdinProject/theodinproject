module Admin
  class ApprovalsController < ApplicationController
    before_action :authorize_admin

    def index
      if params[:search_term].present?
        submissions = ProjectSubmission.includes(:user).search_by(params[:search_term])
      else
        submissions = ProjectSubmission.includes(:user)
      end

      @pagy, @submissions = pagy(submissions.order(created_at: :desc), items: 20)
    end

    def show
      @approval = ProjectSubmission.find(params[:id])
    end

    private

    def authorize_admin
      return if AdminUserPolicy.new(current_admin_user).delete_learner?

      redirect_to admin_learners_path, alert: 'You are not authorized to perform this action'
    end
  end
end
