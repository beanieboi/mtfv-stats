class OverviewController < ApplicationController
  def index
    @league = League.find(league_id)
    @teams = @league.rankings
    @singles = PlayerStats.where(league_id: league_id).includes(:player).rank_order("single")
    @doubles = PlayerStats.where(league_id: league_id).includes(:player).rank_order("double")
    @overall = PlayerStats.where(league_id: league_id).includes(:player).rank_order("overall")
    @pairs = DoubleStats.where(league_id: league_id).order("overall_performance_index DESC")
  end

  def league_id
    params[:league_id] || League.first.id
  end
end
