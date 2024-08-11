namespace :heroku do
  desc 'Heroku release task - runs on every code push, runs before postdeploy task'
  task release: :environment do
    if ActiveRecord::Base.connection.schema_migration.table_exists?
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
      Rake::Task['curriculum:content:import'].invoke
    else
      Rails.logger.info 'Database not initialized, skipping database migration.'
    end
  end

  desc 'Heroku postdeploy task - runs only on review app creation, after release task'
  task postdeploy: :environment do
    Rake::Task['db:schema:load'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['curriculum:content:import'].invoke
  end
end
