source 'https://rubygems.org'

ruby '3.2.3'

gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

gem 'pg', '~> 1.1'
gem 'sprockets-rails'

gem 'puma', '>= 5.0'

gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

gem 'haml-rails', '~> 2.1'
gem 'simple_form'

gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'connection_pool', '~> 2.4', '>= 2.4.1'
gem 'redis', '~> 5.1'
gem 'sidekiq', '~> 7.2', '>= 7.2.2'

group :development, :test do
  gem 'dotenv-rails', '~> 3.1'
  gem 'pry-rails', '~> 0.3.9'
end

group :development do
  gem 'rubocop-rails', '~> 2.24', '>= 2.24.1'
  gem 'rubocop-rspec', '~> 2.27', '>= 2.27.1'
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'
end
