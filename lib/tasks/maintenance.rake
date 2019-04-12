namespace :maintenance do
  desc "do all"
  task all: [:order_player_ids, :populate_matches, :populate_teams] do
  end

  desc "Order all Player Ids in results"
  task order_player_ids: :environment do
    Result.find_in_batches do |results|
      results.each do |result|
        ResultStats.generate(result)
      end
    end
  end

  desc "Populate scores and goals in matches"
  task populate_matches: :environment do
    Match.find_in_batches do |matches|
      matches.each do |match|
        MatchStats.generate(match)
      end
    end
  end

  desc "Populate scores and goals in Teams"
  task populate_teams: :environment do
    Team.find_in_batches do |teams|
      teams.each do |team|
        TeamStats.generate(team)
      end
    end
  end

  desc "Populate scores and goals in Players"
  task populate_teams: :environment do
    Player.find_in_batches do |players|
      players.each do |player|
        PlayerStats.generate(player)
      end
    end
  end
end
