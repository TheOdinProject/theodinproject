class DestroyExpiredLessonPreviewsJob < ApplicationJob
  def perform
    LessonPreview.expired.each(&:destroy)
  end
end
