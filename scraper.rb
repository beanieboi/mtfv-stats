require 'rubygems'
require 'bundler'

Bundler.require(:scraper)

class League
  LANDESKLASSE_1 = "http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=veranstaltung&veranstaltungid=37"
end

@agent = Mechanize.new

@agent.get(League::LANDESKLASSE_1).search("p.posted")