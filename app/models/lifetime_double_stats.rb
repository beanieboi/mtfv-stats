class LifetimeDoubleStats < ApplicationRecord
  def players
    @players ||= Player.where("id IN (?)", player_ids)
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

  # this is a database view
  def readonly?
    true
  end
end
