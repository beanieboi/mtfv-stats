class Result < ApplicationRecord
  def home_score
    home_goals > away_goals ? 1 : 0
  end

  def away_score
    home_goals > away_goals ? 0 : 1
  end
end
