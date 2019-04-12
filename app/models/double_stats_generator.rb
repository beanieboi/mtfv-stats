class DoubleStatsGenerator
  def self.generate(pair)
    return if pair.pair_ids == []

    pair.leagues.each do |league|
      stats = {
        overall_score: pair.home_results_in_league(league).collect(&:home_score).reduce(0, :+) +
          pair.away_results_in_league(league).collect(&:away_score).reduce(0, :+),
        overall_score_against: pair.home_results_in_league(league).collect(&:away_score).reduce(0, :+) +
          pair.away_results_in_league(league).collect(&:home_score).reduce(0, :+),
        overall_goals: pair.home_results_in_league(league).collect(&:home_goals).reduce(0, :+) +
          pair.away_results_in_league(league).collect(&:away_goals).reduce(0, :+),
        overall_goals_against: pair.home_results_in_league(league).collect(&:away_goals).reduce(0, :+) +
          pair.away_results_in_league(league).collect(&:home_goals).reduce(0, :+),
      }

      DoubleStats.find_or_initialize_by(league_id: league.id, player_ids: pair.pair_ids).update(stats)
    end
  end
end
