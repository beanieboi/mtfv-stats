namespace :stats do
  desc "do all"
  task all: [:matches, :teams, :players, :doubles] do
  end

  desc "Populate scores and goals in matches"
  task matches: :environment do
    puts "creating match stats"
    Match.find_in_batches do |matches|
      matches.each do |match|
        MatchStats.generate(match)
      end
    end
  end

  desc "Populate scores and goals in Teams"
  task teams: :environment do
    puts "creating team stats"
    Team.find_in_batches do |teams|
      teams.each do |team|
        TeamStatsGenerator.generate(team)
      end
    end
  end

  desc "Populate scores and goals in Players"
  task players: :environment do
    puts "creating player stats"
    Player.find_in_batches do |players|
      players.each do |player|
        PlayerStatsGenerator.generate(player)
      end
    end
  end

  desc "Populate scores and goals for Doubles"
  task doubles: :environment do
    puts "creating double stats"
    pairs = Result.doubles.collect(&:home_players) + Result.doubles.collect(&:away_players)
    pairs.uniq.each do |pair_players|
      pair = DoublePair.new(pair_players)
      DoubleStatsGenerator.generate(pair)
    end
  end
end
