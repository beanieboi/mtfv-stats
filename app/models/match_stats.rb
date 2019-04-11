class MatchStats
  def self.generate(match)
    match.home_goals = match.results.collect(&:home_goals).inject(:+)
    match.away_goals = match.results.collect(&:away_goals).inject(:+)
    match.home_score = match.results.collect(&:home_score).inject(:+)
    match.away_score = match.results.collect(&:away_score).inject(:+)
    match.save
  end
end