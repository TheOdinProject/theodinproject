# frozen_string_literal: true

if Rails.env.local?
  require 'rspec/core/rake_task'

  namespace :spec do
    # Usage: `bin/rails spec:fast`
    desc 'Run all specs except system specs'
    RSpec::Core::RakeTask.new(:fast) do |t|
      t.exclude_pattern = 'spec/system/**/*'
      t.rspec_opts = '--order rand'
      t.verbose = false
    end
  end
end
