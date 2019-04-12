class DoubleStats < ApplicationRecord
  before_save :calculate_performance_index

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

  def calculate_performance_index
    self.overall_performance_index = begin
      (overall_score * overall_score * 100) / (overall_score + overall_score_against)
    rescue ZeroDivisionError
      0
    end
  end
end
