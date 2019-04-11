namespace :maintenance do
  desc "do all"
  task all: [:order_player_ids, :populate_matches, :populate_teams] do
  end

  desc "Order all Player Ids in results"
  task order_player_ids: :environment do
    Result.find_in_batches do |results|
      results.each do |result|
        result.home_player_ids = result.home_player_ids.sort
        result.away_player_ids = result.away_player_ids.sort
        result.save
      end
    end
  end

  desc "Populate scores and goals in matches"
  task populate_matches: :environment do
    Match.find_in_batches do |matches|
      matches.each do |match|
        match.home_goals = match.results.collect(&:home_goals).inject(:+)
        match.away_goals = match.results.collect(&:away_goals).inject(:+)
        match.home_score = match.results.collect(&:home_score).inject(:+)
        match.away_score = match.results.collect(&:away_score).inject(:+)
        match.save
      end
    end
  end

  desc "Populate scores and goals in Teams"
  task populate_teams: :environment do
    Team.find_in_batches do |teams|
      teams.each do |team|
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
  end
end
