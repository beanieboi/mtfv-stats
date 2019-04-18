class LifetimeDoubleStats < ApplicationRecord
  # this is for performance reasons
  def players
    self.player_data.split("|||").map do |player|
      id, name = player.split("---")
      PlayerBox.new(id: id, name: name)
    end
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
