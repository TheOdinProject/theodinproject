FEATURE_FLAGS = %i[survey_feature].freeze

# Add any new feature flags
FEATURE_FLAGS.each do |flag|
  next if Flipper.exist?(flag)

  Rails.logger.debug { "🚀 Adding feature flag: #{flag}" }
  Flipper.add(flag)
end

# By default, always enable feature flags in development and staging environments
if Rails.env.development? || ENV['STAGING'] == 'true'
  FEATURE_FLAGS.each do |flag|
    next if Flipper.enabled?(flag)

    Rails.logger.debug { "🚀 Enabling feature flag: #{flag}" }
    Flipper.enable(flag)
  end
end

# Remove any feature flags that are no longer needed
Flipper.features.each do |feature|
  next if FEATURE_FLAGS.include?(feature.key.to_sym)

  Rails.logger.debug { "🗑 Removing feature flag: #{feature.key}" }
  feature.remove
end
