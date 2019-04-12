class League < ApplicationRecord
  belongs_to :season
  has_many :teams
  has_many :matches

  def rankings
    self.teams.order("points DESC").order(
      Arel.sql("score-score_against DESC")
    ).all
  end
end
