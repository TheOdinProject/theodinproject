module ProjectSubmissions
  class ItemComponent < ApplicationComponent
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
  end
end
