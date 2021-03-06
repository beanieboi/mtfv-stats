class Team < ApplicationRecord
  has_many :players
  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"

  def matches
    home_matches.or(away_matches)
  end

  def score_difference
    score - score_against
  end

  def goal_difference
    goals - goals_against
  end
end
