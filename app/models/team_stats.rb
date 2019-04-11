class TeamStats
  def self.generate(team)
    team.goals = team.home_matches.collect(&:home_goals).inject(:+) +
      team.away_matches.collect(&:away_goals).inject(:+)
    team.goals_against = team.home_matches.collect(&:away_goals).inject(:+) +
      team.away_matches.collect(&:home_goals).inject(:+)
    team.score = team.home_matches.collect(&:home_score).inject(:+) +
      team.away_matches.collect(&:away_score).inject(:+)
    team.score_against = team.    home_matches.collect(&:away_score).inject(:+) +
      team.away_matches.collect(&:home_score).inject(:+)

    team.matches_won = team.home_matches.where("home_score > away_score").count +
      team.away_matches.where("away_score > home_score").count

    team.matches_lost = team.home_matches.where("home_score < away_score").count +
      team.away_matches.where("away_score < home_score").count

    team.matches_draw = team.home_matches.where("home_score = away_score").count +
      team.away_matches.where("away_score = home_score").count

    team.points = (team.matches_won * 2) + team.matches_draw

    team.save
  end
end