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
    ##
    # uncomment if you're using SimpleCov and have started it in `rails_helper` as suggested here:
    # @see https://github.com/simplecov-ruby/simplecov/tree/main?tab=readme-ov-file#use-it-with-any-framework
    SimpleCov.at_fork.call(test_env_number)

    Capybara.server_port = 3001 + test_env_number
    # config.server_port = 3001 + ENV['TEST_ENV_NUMBER'].to_i
    Capybara.app_host = "http://localhost:#{Capybara.server_port}"

    config = ActiveRecord::Base.connection_db_config.configuration_hash

    ActiveRecord::Base.establish_connection(
      config.merge(
        database: config.fetch(:database) + test_env_number.to_s
      )
    )
  end
end
