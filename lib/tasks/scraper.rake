namespace :scraper do
  desc "Scrape mtfv1.de"
  task :fetch, [:year] => [:environment] do |t, args|
    Bundler.require(:scraper)

    year = args[:year]
    require 'scraper/fetcher'
    require 'scraper/extractor'

    Scraper::Fetcher.run(year)
  end
end
