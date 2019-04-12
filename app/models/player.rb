class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :stats, class_name: "PlayerStats"

  def home_results_single
    Result.where("home_player_ids @> ARRAY[?]", self.id).
      where("array_length(home_player_ids, 1) = 1")
  end

  def home_results_double
    Result.where("home_player_ids @> ARRAY[?]", self.id).
      where("array_length(home_player_ids, 1) = 2")
  end

  def away_results_single
    Result.where("away_player_ids @> ARRAY[?]", self.id).
      where("array_length(home_player_ids, 1) = 1")
  end

  def away_results_double
    Result.where("away_player_ids @> ARRAY[?]", self.id).
      where("array_length(home_player_ids, 1) = 2")
  end

  def leagues
    matches.collect(&:league).uniq
  end

  def matches
    results.includes(:match).collect(&:match)
  end

  def results
    home_results.or(away_results)
  end

  def away_results
    away_results_single.or(away_results_double)
  end

  def home_results
    home_results_single.or(home_results_double)
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
