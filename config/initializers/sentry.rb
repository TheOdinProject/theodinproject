Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.enabled_environments = %w[production]
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.send_default_pii = true

  # enable tracing
  config.traces_sample_rate = 0.1

  # enable profiling
  # this is relative to traces_sample_rate
  config.profiles_sample_rate = 1.0

  filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  config.before_send = lambda { |event, _|
    filter.filter(event.to_hash)
  }
end
