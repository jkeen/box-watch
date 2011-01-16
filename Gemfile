source 'http://rubygems.org'

gem 'rails', '3.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'nokogiri'
gem 'rufus-scheduler'
gem 'settingslogic'
gem 'mail'
gem 'delayed_job'
gem 'tracking_number'
gem 'shippinglogic', :git => "https://github.com/jkeen/shippinglogic.git"
# gem 'shippinglogic', :path => "~/Projects/shippinglogic"

group :production do
  gem 'mysql'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capistrano'
end

group :test do
  gem 'factory_girl_rails', :require => 'factory_girl'
  gem 'mocha'
end