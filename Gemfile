source "https://rubygems.org"

ruby "3.2.3"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "sprockets-rails"
gem "pg", "~> 1.1"

gem "puma", ">= 5.0"

gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

gem 'haml-rails', '~> 2.1'
gem 'simple_form'

gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem 'sidekiq', '~> 7.2', '>= 7.2.2'
gem 'redis', '~> 5.1'
gem 'connection_pool', '~> 2.4', '>= 2.4.1'

group :development, :test do
  gem 'dotenv-rails', '~> 3.1'
end

group :development do
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
end

