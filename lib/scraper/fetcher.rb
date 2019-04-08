module Scraper
  class Fetcher
    LANDESKLASSE_1 = "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=37"

    def self.run
      @agent = Mechanize.new

      Extractor.teams_from_page(
        @agent.get(LANDESKLASSE_1)
      )
    end
  end
end
