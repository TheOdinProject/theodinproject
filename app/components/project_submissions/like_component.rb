module ProjectSubmissions
  class LikeComponent < ApplicationComponent
    def initialize(project_submission)
      @project_submission = project_submission
    end

    private

    attr_reader :project_submission

    def http_action
      project_submission.liked? ? :delete : :post
    end

    def bg_color_class
      project_submission.liked? ? 'text-teal-700' : 'text-gray-400'
    end
  end
end
