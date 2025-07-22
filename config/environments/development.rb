require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.asset_host = 'http://localhost:3000'
  config.action_mailer.default_url_options = {
    host: ENV.fetch('HOST', 'localhost'),
    port: ENV.fetch('HOST_PORT', 3000)
  }
  routes.default_url_options = {
    host: ENV.fetch('HOST', 'localhost'),
    port: ENV.fetch('HOST_PORT', 3000)
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  config.active_record.encryption.support_sha1_for_non_deterministic_encryption = true

  config.active_record.encryption.primary_key = 'C697JaYLcwzaSkxtmnedQad2Tl369h4P'
  config.active_record.encryption.deterministic_key = '7Db9oVtlyUn59MkoSnqnwBo17eJqqw7w'
  config.active_record.encryption.key_derivation_salt = 'IlKDRto84iBwxg09w0nbBqlWBe8a2NWT'

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions
  config.action_controller.raise_on_missing_callback_actions = true

  # Watch files changes with listen gem to speed up propshaft compilation
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Settings for view component previews https://viewcomponent.org/guide/previews.html
  config.view_component.preview_paths << Rails.root.join('spec/components/previews')
  config.view_component.default_preview_layout = 'component_preview'
end
