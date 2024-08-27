require 'simplecov'

SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Rails.root.glob('spec/support/**/*.rb').each { |f| require f }
ActiveRecord::Migration[6.0].maintain_test_schema!

require 'dotenv'
Dotenv.load('.env.test')

RSpec.configure do |config|
  SeedFu.quiet = true

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false
  config.filter_rails_from_backtrace!
  config.order = 'random'
  config.example_status_persistence_file_path = './spec/examples.txt'
  config.expect_with :rspec do |expectations|
    expectations.max_formatted_output_length = nil
  end
end
