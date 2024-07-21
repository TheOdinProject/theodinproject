class RefreshMaterializedViewsJob < ApplicationJob
  queue_as :default

  def perform
    [
      Reports::AllLessonCompletionsDayStat,
      Reports::PathLessonCompletionsDayStat,
      Reports::UserSignUpsDayStat
    ].each(&:refresh)
  end
end
