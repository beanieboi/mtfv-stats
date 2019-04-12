class Playerstat < ApplicationRecord
  def self.generate(player)
    player.leagues.each do |league|
      {
        goals: player.home_results.collect(&:home_goals).inject(:+) +
          player.away_results.collect(&:away_goals).inject(:+)
      }
    end
  end
end
