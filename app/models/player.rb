class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :stats, class_name: "PlayerStats"

  def close_results_won
    close_home_results_won.or(close_away_results_won).joins(:match).
      order("played_at DESC")
  end

  def close_results_lost
    close_home_results_lost.or(close_away_results_lost).joins(:match).
      order("played_at DESC")
  end

  def close_home_results_won
    Result.where("results.home_goals - results.away_goals < ?", 3).
      where("results.home_goals > results.away_goals").
      where("results.home_goals > 5").
      where("home_player_ids @> ARRAY[?]", self.id)
  end

  def close_away_results_won
    Result.where("results.away_goals - results.home_goals < ?", 3).
      where("results.away_goals > results.home_goals").
      where("results.away_goals > 5").
      where("away_player_ids @> ARRAY[?]", self.id)
  end

  def close_home_results_lost
    Result.where("results.away_goals - results.home_goals < ?", 3).
      where("results.home_goals < results.away_goals").
      where("results.away_goals > 5").
      where("home_player_ids @> ARRAY[?]", self.id)
  end

  def close_away_results_lost
    Result.where("results.home_goals - results.away_goals < ?", 3).
      where("results.away_goals < results.home_goals").
      where("results.home_goals > 5").
      where("away_player_ids @> ARRAY[?]", self.id)
  end

  def double_stats
    DoubleStats.for_player(self)
  end

  def home_results_single_in_league(league)
    Result.singles.in_league(league).for_home_player(self)
  end

  def home_results_double_in_league(league)
    Result.doubles.in_league(league).for_home_player(self)
  end

  def away_results_single_in_league(league)
    Result.singles.in_league(league).for_away_player(self)
  end

  def away_results_double_in_league(league)
    Result.doubles.in_league(league).for_away_player(self)
  end

  def double_results_in_league(league)
    home_results_double_in_league(league).or(away_results_double_in_league(league))
  end

  def away_results_in_league(league)
    away_results_single_in_league(league).or(away_results_double_in_league(league))
  end

  def home_results_in_league(league)
    home_results_single_in_league(league).or(home_results_double_in_league(league))
  end

  def away_results_in_league(league)
    away_results_single_in_league(league).or(away_results_double_in_league(league))
  end

  def home_results_in_league(league)
    home_results_single_in_league(league).or(home_results_double_in_league(league))
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

  def home_results
    home_results_single.or(home_results_double)
  end

  def away_results
    away_results_single.or(away_results_double)
  end

  def home_results_single
    Result.singles.for_home_player(self)
  end

  def home_results_double
    Result.doubles.for_home_player(self)
  end

  def away_results_single
    Result.singles.for_away_player(self)
  end

  def away_results_double
    Result.doubles.for_away_player(self)
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
