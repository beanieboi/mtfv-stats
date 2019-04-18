class LifetimeController < ApplicationController
  def index
    @singles = LifetimePlayerStats.includes(:player).rank_order("single")
    @doubles = LifetimePlayerStats.includes(:player).rank_order("double")
    @overall = LifetimePlayerStats.includes(:player).rank_order("overall")
    @pairs = LifetimeDoubleStats.order("overall_performance_index DESC")
  end
end
