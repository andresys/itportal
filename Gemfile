source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 6.4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.1'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

gem 'sprockets-rails'
gem "jsbundling-rails", "~> 1.3"
gem "cssbundling-rails", "~> 1.4"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'turbo-rails', '~> 1.5.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 3.3.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  gem 'progress_bar'
  gem "letter_opener", "~> 1.8"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '~> 4.10.0'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'slim'
gem 'securerandom'
gem 'net-ldap'
gem 'activeldap'
gem 'bindata', '~> 2'

gem 'friendly_id', '~> 5.5.1'

#gem 'http_accept_language'
#gem 'simple-navigation'
#gem 'has_barcode'
gem "rqrcode", "~> 2.0"
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'cupsffi'
gem 'kaminari'
gem 'sidekiq'
gem 'httparty'
gem 'json'
gem 'activejob-status', '~> 1.0.1'
gem 'activerecord-import', '~> 1.5.1'
gem 'draper'
gem 'awesome_nested_set'
gem 'rails_sortable'
gem "devise", "~> 4.9.3"
gem "rails-i18n", "~> 7.0"
# gem 'russian'
gem "sidekiq-scheduler", "~> 5.0"

gem "pundit", "~> 2.3"
gem "rolify", "~> 6.0"

gem "rails-settings-cached", "~> 2.9"
gem "stimulus-rails", "~> 1.3"
