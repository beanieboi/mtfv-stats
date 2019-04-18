class DoubleStats < ApplicationRecord
  belongs_to :league
  before_save :calculate_performance_index

  def self.for_player(player)
    where("player_ids @> ARRAY[?]", player.id).order(:league_id)
  end

  def players
    Player.where("id IN (?)", player_ids)
  end

  def goal_difference
    overall_goals - overall_goals_against
  end

  def total_score
    overall_score + overall_score_against
  end

  def percentage
    (overall_score * 100 / total_score).to_i
  end

  def position
    all = DoubleStats.where(league_id: league_id).order("overall_performance_index DESC")
    all.find_index { |s| s.id == id } + 1
  end

  def calculate_performance_index
    self.overall_performance_index = begin
      (overall_score * overall_score * 100) / (overall_score + overall_score_against)
    rescue ZeroDivisionError
      0
    end
  end
end
