source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', '~> 6.0.0.beta3'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem "bulma-rails", "~> 0.7.4"
gem "scenic"

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
  gem 'chromedriver-helper'
end
