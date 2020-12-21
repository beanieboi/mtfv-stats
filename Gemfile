source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.0.rc1'
gem 'pg'
gem 'puma'
gem 'barnes' # Heroku Ruby Metrics
gem 'scenic'

gem 'sass-rails', '~> 5.0'
gem 'bulma-rails', "~> 0.7.4"
gem 'chart-js-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.1', require: false

group :scraper do
  gem 'mechanize'
  gem 'nokogiri'
end

group :development, :test do
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov'
end
