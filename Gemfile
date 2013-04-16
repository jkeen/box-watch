source 'http://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'nokogiri'
gem 'settingslogic'
gem 'mail'
gem 'tracking_number', :git => "https://github.com/jkeen/tracking_number.git"
gem 'trackerific', :git => "https://github.com/jkeen/trackerific.git"
gem 'jquery-rails'
gem "sidekiq"
gem "whenever"
gem 'geocoder'

group :assets do
  gem 'therubyracer'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier'
  gem 'eco'
end

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end

group :development do
  gem 'dotenv-rails'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capistrano'
  gem 'pry'
  gem 'jasmine'
end

group :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'factory_girl_rails'
  gem 'jasmine'
  gem 'mocha', :require => "mocha/setup"
end
