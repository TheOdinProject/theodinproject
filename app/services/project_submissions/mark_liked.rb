module ProjectSubmissions
  class MarkLiked
    def initialize(user:, project_submissions:)
      @user = user
      @project_submissions = project_submissions
    end

    def self.call(**args)
      new(**args).call
    end

    def call
      project_submissions.each do |submission|
        next if liked_submission_ids.exclude?(submission.id)

        submission.like!
      end
    end

    private

    attr_reader :user, :project_submissions

    def liked_submission_ids
      @liked_submission_ids ||= user.votes.where(votable: project_submissions).pluck(:votable_id)
    end
  end
end
