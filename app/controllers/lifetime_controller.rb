class LifetimeController < ApplicationController
  def index
    @singles = LifetimePlayerStats.rank_order("single").limit(15)
    @doubles = LifetimePlayerStats.rank_order("double").limit(15)
    @overall = LifetimePlayerStats.rank_order("overall").limit(15)
    @pairs = LifetimeDoubleStats.order("overall_performance_index DESC")
  end
end
