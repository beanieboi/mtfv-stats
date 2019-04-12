class Result < ApplicationRecord
  belongs_to :match

  def self.in_league(league)
    joins(:match).where(matches: { league_id: league.id })
  end

  def self.singles
    where("array_length(home_player_ids, 1) = 1")
  end

  def self.doubles
    where("array_length(home_player_ids, 1) = 2")
  end

  def self.for_home_player(player)
    where("home_player_ids @> ARRAY[?]", player.id)
  end

  def self.for_away_player(player)
    where("away_player_ids @> ARRAY[?]", player.id)
  end

  def home_players
    Player.where("id IN (?)", home_player_ids)
  end

  def away_players
    Player.where("id IN (?)", away_player_ids)
  end

  def home_score
    home_goals > away_goals ? 1 : 0
  end

  def away_score
    home_goals > away_goals ? 0 : 1
  end
end
