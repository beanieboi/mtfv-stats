namespace :scraper do
  desc "Scrape mtfv1.de"
  task fetch: :environment do
    Bundler.require(:scraper)

    require 'scraper/fetcher'
    require 'scraper/extractor'

    Scraper::Fetcher.run
  end
end
