module Scraper
  class Fetcher
    LANDESKLASSE_1 = "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=37"

    def self.run
      @agent = Mechanize.new
      overview_page = @agent.get(LANDESKLASSE_1)
      season = Season.find_or_create_by!(name: "2019")
      league = League.create_with(
        name: "Landesklasse 1",
        season_id: season.id,
      ).find_or_create_by!(external_mtfv_id: 37)

      Extractor.teams_from_page(league, overview_page)
      Extractor.matches_from_page(league, overview_page)
    end
  end
end
