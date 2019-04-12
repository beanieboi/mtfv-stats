class OverviewController < ApplicationController
  def index
    @seasons = Season.all
    @season = Season.find(season_id)
    @leagues = @season.leagues
    @league = League.find(league_id)
    @teams = @league.rankings
  end

  def league_id
    params[:season_id] || @season.leagues.first.id
  end

  def season_id
    params[:season_id] || Season.first.id
  end
end


__END__
Leistungsindex
(SP+ * SP+ * 100) / (SP+ + SP-), Spielpunkte gewonnen, ...

(23*23*100)/(23+3)