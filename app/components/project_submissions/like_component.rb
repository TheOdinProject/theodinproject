module ProjectSubmissions
  class LikeComponent < ApplicationComponent
    def initialize(project_submission:, current_users_submission: false)
      @project_submission = project_submission
      @current_users_submission = current_users_submission
    end

    private

    attr_reader :project_submission, :current_users_submission

    def bg_color_class
      return 'text-teal-700 stroke-teal-700' if current_users_submission || project_submission.liked?

      'stroke-gray-500 stroke-2 text-transparent'
    end

    def tooltip_text
      return 'Unlike solution' if current_users_submission || project_submission.liked?

      'Like solution'
    end
  end
end
