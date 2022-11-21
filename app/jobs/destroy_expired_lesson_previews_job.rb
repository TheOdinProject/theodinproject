class DestroyExpiredLessonPreviewsJob
  include Sidekiq::Worker
  sidekiq_options retry: 1, dead: false

  def perform
    LessonPreview.expired.each(&:destroy)
  end
end
