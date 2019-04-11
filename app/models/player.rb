class Player < ApplicationRecord
  belongs_to :team, optional: true

  def home_results
    Result.where("home_player_ids @> ARRAY[?]", self.id)
  end

  def away_results
    Result.where("away_player_ids @> ARRAY[?]", self.id)
  end

  def results
    home_results.or(away_results)
  end
end
