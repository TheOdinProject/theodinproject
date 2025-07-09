module Admin
  class ApprovalsController < Admin::BaseController
    before_action :authorize_admin
    before_action :set_submission, only: %i[approve reject show]

    def index
      @submissions = ProjectSubmission.all
    end

    def approve
      update_submission(true, 'Submission approved!')
    end

    def reject
      update_submission(false, 'Submission rejected!')
    end

    def show
    end

    private

    def authorize_admin
      return if current_admin_user.core?

      redirect_to admin_learners_path, alert: 'You are not authorized to perform this action'
    end

    def set_submission
      @project_submission = ProjectSubmission.find(params[:id])
    end

    def update_submission(status, message)
      @project_submission.update(is_approved: status)
      redirect_to admin_approvals_path, notice: message
    end
  end
end
