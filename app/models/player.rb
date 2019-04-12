class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :stats, class_name: "PlayerStats"

  def home_results
    Result.where("home_player_ids @> ARRAY[?]", self.id)
  end

  def away_results
    Result.where("away_player_ids @> ARRAY[?]", self.id)
  end

  def results
    home_results.or(away_results)
  end

  def goals
    home_results.collect(&:home_goals).inject(:+) +
      away_results.collect(&:away_goals).inject(:+)
  end

  def goals_against
    home_results.collect(&:away_goals).inject(:+) +
      away_results.collect(&:home_goals).inject(:+)
  end
end
