class TeamStatsGenerator
  def self.generate(team)
    team.goals = team.home_matches.collect(&:home_goals).reduce(0, :+) +
      team.away_matches.collect(&:away_goals).reduce(0, :+)
    team.goals_against = team.home_matches.collect(&:away_goals).reduce(0, :+) +
      team.away_matches.collect(&:home_goals).reduce(0, :+)
    team.score = team.home_matches.collect(&:home_score).reduce(0, :+) +
      team.away_matches.collect(&:away_score).reduce(0, :+)
    team.score_against = team.    home_matches.collect(&:away_score).reduce(0, :+) +
      team.away_matches.collect(&:home_score).reduce(0, :+)

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
