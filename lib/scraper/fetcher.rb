module Scraper
  class Fetcher
    SCRAPE_URLS = [
      {
        "season" => "2019",
        "leagues" => [
          # { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=34" },
          { "name" => "Landesklasse 1", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=37" }
        ]
      }
    ]

    def self.run
      @agent = Mechanize.new

      SCRAPE_URLS.each do |entry|
        season = Season.find_or_create_by!(name: entry["season"])

        entry["leagues"].each do |league_entry|
          overview_page = @agent.get(league_entry["url"])

          external_league_id = CGI::parse(league_entry["url"])["veranstaltungid"].first

          league = League.create_with(
            name: league_entry["name"],
            season_id: season.id,
          ).find_or_create_by!(external_mtfv_id: external_league_id)

          puts "importing season #{entry["season"]} #{league_entry["name"]}"

          Extractor.teams_from_page(league, overview_page)
          Extractor.matches_from_page(league, overview_page)
        end
      end
    end
  end
end
