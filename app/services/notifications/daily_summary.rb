module Notifications
  class DailySummary
    def message
      "**TOP Summary For #{Date.current.to_fs(:long_ordinal)}**\n" \
        "#{User.where('created_at >= ?', start_of_day).size} users signed up\n" \
        "#{LessonCompletion.created_today.size} lessons completed\n" \
        "#{ProjectSubmission.created_today.size} project submissions added\n" \
        "#{Like.created_today.size} projects liked"
    end

    def destination
      ENV['DISCORD_LESSON_COMPLETION_WEBHOOK_URL']
    end

    private

    attr_reader :course

    def start_of_day
      Time.zone.now.beginning_of_day
    end
  end
end
