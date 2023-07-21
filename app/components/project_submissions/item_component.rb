module ProjectSubmissions
  class ItemComponent < ApplicationComponent
    CURRENT_USER_SORT_CODE = 10_000_000 # current user's submission should always be first

    with_collection_parameter :project_submission
    renders_one :title, ProjectSubmissions::TitleComponent

    def initialize(project_submission:, current_user:, edit_path: nil)
      @project_submission = project_submission
      @current_user = current_user
      @edit_path = edit_path
    end

    def render?
      project_submission.present?
    end

    private

    attr_reader :project_submission, :current_user

    def current_users_submission?
      project_submission.user == current_user
    end

    def sort_code
      return CURRENT_USER_SORT_CODE if current_users_submission?

      project_submission.cached_votes_total
    end

    def edit_path
      return @edit_path if @edit_path.present?

      edit_lesson_v2_project_submission_path(project_submission.lesson, project_submission)
    end
  end
end
