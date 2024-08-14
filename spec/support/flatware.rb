if defined?(Flatware)
  Flatware.configure do |conf|
    conf.before_fork do
      require 'rails_helper'

      ActiveRecord::Base.connection.disconnect!

      $stdout.puts "\n🐢  Precompiling assets.\n"
      original_stdout = $stdout.clone

      start = Time.current
      begin
        $stdout.reopen(File.new('/dev/null', 'w'))
        system('bin/rails test:prepare') # invokes css:build and javascript:build
      ensure
        $stdout.reopen(original_stdout)
        $stdout.puts "Finished in #{(Time.current - start).round(2)} seconds"
      end
    end

    conf.after_fork do |test_env_number|
      SimpleCov.at_fork.call(test_env_number)

      # Set the port for the test environment - needed for emails to function properly
      Rails.configuration.action_mailer.default_url_options[:port] = 3001 + test_env_number
      Rails.application.routes.default_url_options[:port] = 3001 + test_env_number

      Capybara.server_port = 3001 + test_env_number
      Capybara.app_host = "http://localhost:#{Capybara.server_port}"

      config = ActiveRecord::Base.connection_db_config.configuration_hash

      ActiveRecord::Base.establish_connection(
        config.merge(
          database: config.fetch(:database) + test_env_number.to_s
        )
      )
    end
  end
end
