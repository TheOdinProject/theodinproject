module ProjectSubmissions
  class ItemComponent < ApplicationComponent
    CURRENT_USER_SORT_CODE = 10_000_000 # current user's submission should always be first

    with_collection_parameter :project_submission

    def initialize(project_submission:, current_user:)
      @project_submission = project_submission
      @current_user = current_user
    end

    def render?
      project_submission.present?
    end

    private

    attr_reader :project_submission, :current_user

    def sort_code
      return CURRENT_USER_SORT_CODE if project_submission.user == current_user

      project_submission.cached_votes_total
    end
  end
end
