class ResultStats
  def self.generate(result)
    result.home_player_ids = result.home_player_ids.sort
    result.away_player_ids = result.away_player_ids.sort
    result.save
  end
end