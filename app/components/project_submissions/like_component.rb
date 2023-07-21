module ProjectSubmissions
  class LikeComponent < ApplicationComponent
    def initialize(project_submission:, current_users_submission: false)
      @project_submission = project_submission
      @current_users_submission = current_users_submission
    end

    private

    attr_reader :project_submission, :current_users_submission

    def http_action
      project_submission.liked? ? :delete : :post
    end

    def bg_color_class
      return 'text-teal-700' if current_users_submission || project_submission.liked?

      'text-gray-400'
    end
  end
end
