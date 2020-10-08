source 'https://rubygems.org'
ruby '~> 2.6'

gem 'rails', '6.0.3.4'

gem 'activeadmin', '>= 2.8.1'
gem 'activeadmin_addons', '~> 1.7.1'
gem 'active_material'
gem 'bootstrap', '>= 4.5.2'
gem 'cancancan'
gem 'devise', '>= 4.7.3'
gem 'discordrb-webhooks'
gem 'friendly_id', '~> 5.4'
gem 'gibbon', '~> 3.3.4'
gem 'github_api', '~> 0.19'
gem 'jquery-rails', '~> 4.4.0'
gem 'kaminari', '~> 1.2'
gem 'kramdown'
gem 'newrelic_rpm'
gem 'nokogiri', '~> 1.10.10'
gem 'octokit', '~> 4.6'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '>= 0.1.2'
gem 'pg', '~> 1.2'
gem 'premailer-rails', '~> 1.11', '>= 1.11.1'
gem 'puma'
gem 'rack-attack'
gem 'react-rails', '>= 2.6.1'
gem 'sass-rails', '~> 6.0', '>= 6.0.0'
gem 'sprockets', '~> 3.7.2'
gem 'toastr-rails', '>= 1.0.3'
gem 'turbolinks'
gem 'uglifier', '~> 4.2'
gem 'webpacker', '>= 5.2.1'

group :production do
  gem 'rails_12factor', '~> 0.0.3'
  gem 'skylight'
end

group :development, :test, :docker do
  gem 'climate_control'
  gem 'database_cleaner', '~> 1.8'
  gem 'dotenv-rails', '>= 2.7.6'
  gem 'factory_bot'
  gem 'factory_bot_rails', '~> 6', '>= 6.1.0'
  gem 'pry', '~> 0.13.1'
  gem 'rails-controller-testing', '>= 1.0.5'
  gem 'rake', '~> 13.0'
  gem 'rspec-rails', '>= 4.0.1'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'vcr', '~> 6.0'
  gem 'webmock', '~> 3.9'
end

group :development, :docker do
  gem 'better_errors'
  gem 'binding_of_caller', '~> 0.8'
  gem 'derailed'
  gem 'letter_opener', '~> 1.4'
  gem 'listen'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'web-console', '>= 4.0.4'
end
