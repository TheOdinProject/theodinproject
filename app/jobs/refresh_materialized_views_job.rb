class RefreshMaterializedViewsJob < ApplicationJob
  queue_as :default

  def perform
    [
      Reports::AllLessonCompletionsDayStat
    ].each(&:refresh)
  end
end
