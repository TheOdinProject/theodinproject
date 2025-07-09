module Admin
  class ApprovalsController < ApplicationController
    before_action :authorize_admin

    def index
      @submissions = ProjectSubmission.all
    end

    def approve
      submission = ProjectSubmission.find(params[:id])
      submission.update(isapproved: true)
      redirect_to admin_approvals_path, notice: 'Submission approved!'
    end

    def reject
      submission = ProjectSubmission.find(params[:id])
      submission.update(isapproved: false)
      redirect_to admin_approvals_path, notice: 'Submission rejected!'
    end

      def show
        @project_submission = ProjectSubmission.find(params[:id])
      end

    private

    def authorize_admin
      return if AdminUserPolicy.new(current_admin_user).delete_learner?

      redirect_to admin_learners_path, alert: 'You are not authorized to perform this action'
    end
  end
end
