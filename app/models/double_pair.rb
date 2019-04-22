class DoublePair
  attr_reader :pair, :pair_ids

  def initialize(pair)
    @pair = pair
    @pair_ids = @pair.collect(&:id).sort
  end

  def home_results
    @home_results ||= Result.where("home_player_ids = ARRAY[?]", @pair_ids)
  end

  def away_results
    @away_results ||= Result.where("away_player_ids = ARRAY[?]", @pair_ids)
  end

  def home_results_in_league(league)
    Rails.cache.fetch("home_results_in_league/#{league.id}/#{@pair_ids.join(',')}") do
      Result.in_league(league).where("home_player_ids = ARRAY[?]", @pair_ids).all.to_a
    end
  end

  def away_results_in_league(league)
    Rails.cache.fetch("away_results_in_league/#{league.id}/#{@pair_ids.join(',')}") do
      Result.in_league(league).where("away_player_ids = ARRAY[?]", @pair_ids).all.to_a
    end
  end

  def leagues
    @leagues ||= matches.collect(&:league).uniq
  end

  def matches
    @matches ||= results.includes(:match, match: :league).collect(&:match)
  end

  def results
    home_results.or(away_results)
  end
end
