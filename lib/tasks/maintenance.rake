namespace :maintenance do
  desc "do all"
  task all: [:order_player_ids, :single_double_integrity] do
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

  desc "Order all Player Ids in results"
  task single_double_integrity: :environment do
    Result.find_in_batches do |results|
      results.each do |result|
        next if result.home_player_ids.count != result.away_player_ids
        raise StandardError, "Result #{result.id} has invalid player pairs"
      end
    end
  end
end
