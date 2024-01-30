class DiscardProjectSubmissionJob < ApplicationJob
  def perform
    ProjectSubmission.discardable.each(&:discard!)
  end
end
