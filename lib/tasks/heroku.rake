namespace :heroku do
  desc 'Heroku release task - runs on every code push, runs before postdeploy task'
  task release: :environment do
    Rake::Task['db:prepare'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['curriculum:content:import'].invoke
  end

  desc 'Heroku postdeploy task - runs only on review app creation, after release task'
  task postdeploy: :environment do
    # No op
  end
end
