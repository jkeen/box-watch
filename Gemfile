source 'http://rubygems.org'

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

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'eco'
end

group :production do
  gem 'mysql'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capistrano'
  gem 'pry'
  gem 'jasmine'
end

group :test do
  gem 'pry'
  gem 'factory_girl_rails'
  gem 'jasmine'
  gem 'mocha', :require => "mocha/setup"
end
