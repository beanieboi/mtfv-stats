source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.0'
gem 'pg'
gem 'puma', '~> 5.5'
gem 'barnes' # Heroku Ruby Metrics
gem 'scenic'

gem 'sass-rails', '>= 6'
gem 'bulma-rails'
gem 'chart-js-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :scraper do
  gem 'mechanize'
  gem 'nokogiri'
end

group :development, :test do
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov'
end
