require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Theodinproject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # ** Please read carefully **
    # Change the format of the cache entry.
    # Changing this to Rails 7.0 means that all new cache entries added to the cache
    # will have a different format that is not supported by Rails 6.1 applications.
    # Only remove this value after your application is fully deployed to Rails 7.0
    # and you have no plans to rollback.

    config.active_support.cache_format_version = 6.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    require Rails.root.join('lib/custom_public_exceptions')
    config.exceptions_app = CustomPublicExceptions.new(Rails.public_path)
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
  end
end
