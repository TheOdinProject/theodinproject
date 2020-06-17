source 'https://rubygems.org'
ruby '~> 2.6'

gem 'rails', '6.0.3.1'

gem 'puma'
gem 'turbolinks'
gem 'jquery-rails', '~> 4.4.0'
gem 'devise', '>= 4.7.1'
gem 'rack-timeout',               '~> 0.4'
gem 'kaminari',                   '~> 1.2'
gem 'pg',                         '~> 1.2'
gem 'premailer-rails', '~> 1.11', '>= 1.11.1'
gem 'github_api', '~> 0.18', '>= 0.18.2'
gem 'octokit',                    '~> 4.6'
gem 'omniauth-github', '>= 1.4.0'
gem 'omniauth-google-oauth2', '>= 0.8.0'
gem 'omniauth-rails_csrf_protection', '>= 0.1.2'
gem 'bootstrap', '>= 4.5.0'
gem 'uglifier',                   '~> 4.2'
gem 'friendly_id',                '~> 5.1'
gem 'cancancan'
gem 'sass-rails', '~> 6.0', '>= 6.0.0'
gem 'rack-attack', '>= 6.3.1'
gem 'acts_as_votable'
gem 'kramdown'
gem 'toastr-rails', '>= 1.0.3'
gem 'gibbon',                     '~> 3.3.4' # for Mailchimp
gem 'nokogiri',                   '~> 1.10.8'
gem 'sprockets', '~> 3.7.2'
gem 'newrelic_rpm'
gem 'activeadmin', '>= 2.7.0'
gem 'webpacker', '>= 5.1.1'
gem 'react-rails', '>= 2.6.1'
gem 'discordrb-webhooks'

group :production do
  gem 'rails_12factor',           '~> 0.0.3'
  gem 'skylight'
end

group :development, :test, :docker do
  gem 'rspec-rails', '>= 4.0.1'
  gem 'simplecov', :require => false
  gem 'factory_bot_rails', '~> 5', '>= 5.2.0'
  gem 'database_cleaner',                 '~> 1.8'
  gem 'webmock',                          '~> 3.8'
  gem 'vcr',                              '~> 6.0'
  gem 'shoulda-matchers'
  gem 'rake',                             '~> 13.0'
  gem 'rails-controller-testing', '>= 1.0.4'
  gem 'dotenv-rails', '>= 2.7.5'
  gem 'pry',                                '~> 0.13.1'
  gem 'factory_bot'
  gem 'climate_control'
  gem 'timecop'
end

group :development, :docker do
  gem 'web-console', '>= 4.0.2'
  gem 'better_errors', '>= 2.7.1'
  gem 'binding_of_caller',                 '~> 0.8'
  gem 'letter_opener',                     '~> 1.4'
  gem 'derailed', '>= 0.1.0'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'listen'
end
