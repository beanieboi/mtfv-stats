source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~>7'
gem 'pg'
gem 'puma'
gem 'scenic'
gem "bootsnap", require: false

gem "sassc-rails"
gem 'bulma-rails'
gem 'chart-js-rails'
gem 'excon'

group :development, :test do
  gem "pry-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "simplecov"
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
