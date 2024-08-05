namespace :data_migrations do
  desc 'Update legacy flag reasons'
  task update_legacy_flag_reasons: :environment do
    legacy_flags = Flag.where(reason: 4)
    puts "Updating reasons for #{legacy_flags.count} legacy flags"

    legacy_flags.each do |flag|
      flag.update!(reason: 40)
    end

    puts 'Done!'
  end
end
