module Scraper
  class Fetcher
    SCRAPE_URLS = [
      {
        "season" => "2019",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=34" },
          { "name" => "Landesliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=35" },
          { "name" => "Landesklasse 1", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=37" },
          { "name" => "Landesklasse 2", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=39" },
        ]
      },
      {
        "season" => "2018",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=31" },
          { "name" => "Landesliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=29" },
          { "name" => "Landesklasse", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=30" },
        ]
      },
      {
        "season" => "2017",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=23" },
          { "name" => "Landesliga Gruppe A", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=24" },
          { "name" => "Landesliga Gruppe B", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=25" },
        ]
      },
      {
        "season" => "2016",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=15" },
          { "name" => "Landesliga Gruppe A", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=17" },
          { "name" => "Landesliga Gruppe B", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=18" },
        ]
      },
      {
        "season" => "2015",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=12" },
          { "name" => "Landesliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=13" },
          # { "name" => "Rookieliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=14" },
        ]
      },
      {
        "season" => "2014",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=10" },
          { "name" => "Landesliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=11" },
        ]
      },
      {
        "season" => "2013",
        "leagues" => [
          { "name" => "Regionalliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=9" },
          { "name" => "Landesliga", "url" => "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=8" },
        ]
      }
    ]

    def self.run(year)
      @agent = Mechanize.new
      Player.create!(name: "Unbekannter Spieler 1", external_mtfv_id: 9999999)
      Player.create!(name: "Unbekannter Spieler 2", external_mtfv_id: 9999998)

      SCRAPE_URLS.each do |entry|
        next if entry["season"] != year

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
