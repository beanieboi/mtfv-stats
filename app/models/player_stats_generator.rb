class PlayerStatsGenerator
    def self.generate(player)
    player.leagues.each do |league|
      stats = {
        overall_score: overall_score(player, league),
        overall_score_against: overall_score_against(player, league),
        overall_goals: overall_goals(player, league),
        overall_goals_against: overall_goals_against(player, league),
        single_score: single_score(player, league),
        single_score_against: single_score_against(player, league),
        single_goals: single_goals(player, league),
        single_goals_against: single_goals_against(player, league),
        double_score: double_score(player, league),
        double_score_against: double_score_against(player, league),
        double_goals: double_goals(player, league),
        double_goals_against: double_goals_against(player, league),
      }

      PlayerStats.find_or_initialize_by(league_id: league.id, player_id: player.id).update(stats)
    end
  end

  def self.overall_score(player, league)
    player.home_results_in_league(league).collect(&:home_score).reduce(0, :+) +
      player.away_results.in_league(league).collect(&:away_score).reduce(0, :+)
  end

  def self.overall_score_against(player, league)
    player.home_results_in_league(league).collect(&:away_score).reduce(0, :+) +
      player.away_results.in_league(league).collect(&:home_score).reduce(0, :+)
  end

  def self.overall_goals(player, league)
    player.home_results_in_league(league).collect(&:home_goals).reduce(0, :+) +
      player.away_results.in_league(league).collect(&:away_goals).reduce(0, :+)
  end

  def self.overall_goals_against(player, league)
    player.home_results_in_league(league).collect(&:away_goals).reduce(0, :+) +
      player.away_results.in_league(league).collect(&:home_goals).reduce(0, :+)
  end

  def self.single_score(player, league)
    player.home_results_single_in_league(league).collect(&:home_score).reduce(0, :+) +
      player.away_results_single.in_league(league).collect(&:away_score).reduce(0, :+)
  end

  def self.single_score_against(player, league)
    player.home_results_single_in_league(league).collect(&:away_score).reduce(0, :+) +
      player.away_results_single.in_league(league).collect(&:home_score).reduce(0, :+)
  end

  def self.single_goals(player, league)
    player.home_results_single_in_league(league).collect(&:home_goals).reduce(0, :+) +
      player.away_results_single.in_league(league).collect(&:away_goals).reduce(0, :+)
  end

  def self.single_goals_against(player, league)
    player.home_results_single_in_league(league).collect(&:away_goals).reduce(0, :+) +
      player.away_results_single.in_league(league).collect(&:home_goals).reduce(0, :+)
  end

  def self.double_score(player, league)
    player.home_results_double_in_league(league).collect(&:home_score).reduce(0, :+) +
      player.away_results_double.in_league(league).collect(&:away_score).reduce(0, :+)
  end

  def self.double_score_against(player, league)
    player.home_results_double_in_league(league).collect(&:away_score).reduce(0, :+) +
      player.away_results_double.in_league(league).collect(&:home_score).reduce(0, :+)
  end

  def self.double_goals(player, league)
    player.home_results_double_in_league(league).collect(&:home_goals).reduce(0, :+) +
      player.away_results_double.in_league(league).collect(&:away_goals).reduce(0, :+)
  end

  def self.double_goals_against(player, league)
    player.home_results_double_in_league(league).collect(&:away_goals).reduce(0, :+) +
      player.away_results_double.in_league(league).collect(&:home_goals).reduce(0, :+)
  end
end
