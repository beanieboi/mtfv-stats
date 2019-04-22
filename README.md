# README

- Ruby version

Ruby 2.6.2

- Configuration

bundler install

- Database creation

bundle exec rails db:create

- Database initialization

bundle exec rails db:migrate

- Create stats

bundle exec rails scraper:fetch\[2019\]
bundle exec rails maintenance:all
bundle exec rails stats:all

- Start app

bundle exec rails s

Visit localhost:3000
