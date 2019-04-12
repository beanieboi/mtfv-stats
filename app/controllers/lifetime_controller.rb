class LifetimeController < ApplicationController
  def index
    @singles = LifetimePlayerStats.rank_order("single").limit(3)
    @doubles = LifetimePlayerStats.rank_order("double").limit(3)
    @overall = LifetimePlayerStats.rank_order("overall").limit(3)
    @pairs = LifetimeDoubleStats.order("overall_performance_index DESC")
  end
end
