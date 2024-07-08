module Notifications
  class DailySummary
    def message
      "**TOP Summary For #{Date.yesterday.to_fs(:long_ordinal)} (UTC)**\n" \
        "#{user_sign_up_count} users signed up\n" \
        "#{lesson_completion_count} lessons completed\n" \
        "#{project_submission_count} project submissions added\n" \
        "#{project_like_count} projects liked"
    end

    def destination
      ENV['DISCORD_LESSON_COMPLETION_WEBHOOK_URL']
    end

    private

    attr_reader :course

    def user_sign_up_count
      User.signed_up_on(Time.zone.yesterday).count
    end

    def lesson_completion_count
      LessonCompletion.completed_on(Time.zone.yesterday).count
    end

    def project_submission_count
      ProjectSubmission.submitted_on(Time.zone.yesterday).count
    end

    def project_like_count
      Like.liked_on(Time.zone.yesterday).count
    end
  end
end
