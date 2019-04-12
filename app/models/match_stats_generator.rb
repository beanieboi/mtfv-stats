class MatchStatsGenerator
  def self.generate(match)
    match.home_goals = match.results.collect(&:home_goals).reduce(0, :+)
    match.away_goals = match.results.collect(&:away_goals).reduce(0, :+)
    match.home_score = match.results.collect(&:home_score).reduce(0, :+)
    match.away_score = match.results.collect(&:away_score).reduce(0, :+)
    match.save
  end
end
