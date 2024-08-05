# rubocop:disable all
namespace :data_migrations do
  desc 'populate flag resolvers'
  task populate_flag_resolvers: :environment do
    puts "Populating resolvers for #{Flag.count} flags"

    resolvers = {
      19863 => 'Timato',
      260969 => 'Mfrnk',
      212391 => 'Sully',
      207444 => 'Rachel',
      1018843 => 'Kevin',
      421591 => 'Kevin',
      932663 => 'Mao',
    }

    Flag.find_each do |flag|
      next if flag.resolved_by_id.blank?

      resolver = resolvers[flag.resolved_by_id]
      next if resolver.blank?

      admin_user = AdminUser.find_by(name: resolver)

      puts "Set admin user on flag #{flag.id} to #{resolver}"
      flag.update!(admin_user: admin_user)
    end

    puts 'Done!'
  end
end
# rubocop:enable all
