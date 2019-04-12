class PlayerStatsGenerator
    def self.generate(player)
    player.leagues.each do |league|
      stats = {
        overall_score: player.home_results_in_league(league).collect(&:home_score).reduce(0, :+) +
          player.away_results.in_league(league).collect(&:away_score).reduce(0, :+),
        overall_score_against: player.home_results_in_league(league).collect(&:away_score).reduce(0, :+) +
          player.away_results.in_league(league).collect(&:home_score).reduce(0, :+),
        overall_goals: player.home_results_in_league(league).collect(&:home_goals).reduce(0, :+) +
          player.away_results.in_league(league).collect(&:away_goals).reduce(0, :+),
        overall_goals_against: player.home_results_in_league(league).collect(&:away_goals).reduce(0, :+) +
          player.away_results.in_league(league).collect(&:home_goals).reduce(0, :+),
        single_score: player.home_results_single_in_league(league).collect(&:home_score).reduce(0, :+) +
          player.away_results_single.in_league(league).collect(&:away_score).reduce(0, :+),
        single_score_against: player.home_results_single_in_league(league).collect(&:away_score).reduce(0, :+) +
          player.away_results_single.in_league(league).collect(&:home_score).reduce(0, :+),
        single_goals: player.home_results_single_in_league(league).collect(&:home_goals).reduce(0, :+) +
          player.away_results_single.in_league(league).collect(&:away_goals).reduce(0, :+),
        single_goals_against: player.home_results_single_in_league(league).collect(&:away_goals).reduce(0, :+) +
          player.away_results_single.in_league(league).collect(&:home_goals).reduce(0, :+),
        double_score: player.home_results_double_in_league(league).collect(&:home_score).reduce(0, :+) +
          player.away_results_double.in_league(league).collect(&:away_score).reduce(0, :+),
        double_score_against: player.home_results_double_in_league(league).collect(&:away_score).reduce(0, :+) +
          player.away_results_double.in_league(league).collect(&:home_score).reduce(0, :+),
        double_goals: player.home_results_double_in_league(league).collect(&:home_goals).reduce(0, :+) +
          player.away_results_double.in_league(league).collect(&:away_goals).reduce(0, :+),
        double_goals_against: player.home_results_double_in_league(league).collect(&:away_goals).reduce(0, :+) +
          player.away_results_double.in_league(league).collect(&:home_goals).reduce(0, :+),
      }

      PlayerStats.find_or_initialize_by(league_id: league.id, player_id: player.id).update(stats)
    end
  end
end
