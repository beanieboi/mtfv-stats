class OverviewController < ApplicationController
  def index
    @seasons = Season.all
    @season = Season.find(season_id)
    @leagues = @season.leagues
    @league = League.find(league_id)
    @teams = @league.rankings
    @singles = PlayerStats.where(league_id: league_id).rank_order("single").limit(3)
    @doubles = PlayerStats.where(league_id: league_id).rank_order("double").limit(3)
    @overall = PlayerStats.where(league_id: league_id).rank_order("overall").limit(3)
    @pairs = DoubleStats.where(league_id: league_id).order("overall_performance_index DESC").limit(3)
  end

  def league_id
    params[:league_id] || @season.leagues.first.id
  end

  def season_id
    params[:season_id] || Season.first.id
  end
end
