class RefreshMaterializedViewsJob < ApplicationJob
  queue_as :default

  def perform
    [
      Reports::AllLessonCompletionsDayStat,
      Reports::PathLessonCompletionsDayStat
    ].each(&:refresh)
  end
end
