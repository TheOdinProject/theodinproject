namespace :lesson_previews do
  desc 'Destroy Expired Lesson Previews'
  task destroy_expired: :environment do
    DestroyExpiredLessonPreviewsJob.new.perform
  end
end
