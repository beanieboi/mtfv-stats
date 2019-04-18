class LifetimePlayerStats < ApplicationRecord
  belongs_to :player

  def self.rank_order(field)
    order(Arel.sql("#{field}_performance_index DESC")).
    order(Arel.sql("#{field}_goals - #{field}_goals_against DESC"))
  end

  def single_goal_difference
    single_goals - single_goals_against
  end

  def single_total_score
    single_score + single_score_against
  end

  def single_percentage
    return 0 if single_total_score == 0
    (single_score * 100 / single_total_score).to_i
  end

  def double_goal_difference
    double_goals - double_goals_against
  end

  def double_total_score
    double_score + double_score_against
  end

  def double_percentage
    return 0 if double_total_score == 0
    (double_score * 100 / double_total_score).to_i
  end

  def overall_goal_difference
    overall_goals - overall_goals_against
  end

  def overall_total_score
    overall_score + overall_score_against
  end

  def overall_percentage
    return 0 if overall_total_score == 0
    (overall_score * 100 / overall_total_score).to_i
  end

  # this is a database view
  def readonly?
    true
  end
end
