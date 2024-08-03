module Notifications
  class FlagSubmission
    include Rails.application.routes.url_helpers

    delegate :flagger, :project_submission, :reason, :extra, to: :flag, private: true

    def initialize(flag)
      @flag = flag
    end

    def message
      "#{flagger.username} has flagged a submission on #{project_submission.lesson.display_title}\n" \
        "Reason: #{reason}\n" \
        "Extra: #{extra}\n" \
        "Resolve the flag here: #{admin_v2_flag_url(flag)}"
    end

    def destination
      ENV['DISCORD_FLAGGED_SUBMISSIONS_CHANNEL']
    end

    private

    attr_reader :flag
  end
end
