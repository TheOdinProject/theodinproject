namespace :data_migrations do
  desc 'Remove old Homepage project submissions'
  task remove_old_homepage_submissions: :environment do
    homepage_project = Lesson.find_by!(title: 'Homepage')
    submissions = homepage_project.project_submissions.where('created_at < ?', 3.months.ago)

    puts "removing #{submissions.count} old Homepage submissions"

    progressbar = ProgressBar.create(total: submissions.count, format: '%t: |%w%i| Completed: %c %a %e')

    submissions.find_each do |submission|
      submission.destroy!
    rescue StandardError => e
      progressbar.log "Error with submission ##{submission.id}: #{e.message}"
    ensure
      progressbar.increment
    end
  end
end
