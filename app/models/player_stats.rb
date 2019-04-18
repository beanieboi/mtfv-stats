class PlayerStats < ApplicationRecord
  belongs_to :player
  belongs_to :league

  before_save :calculate_performance_index

  def self.rank_order(field)
    order(Arel.sql("#{field}_performance_index DESC")).
    order(Arel.sql("#{field}_goals - #{field}_goals_against DESC"))
  end

  def self.lifetime
    select("id, player_id").group(:player_id)
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

  def position(order)
    all = PlayerStats.where(league_id: league_id).rank_order(order)
    all.find_index { |s| s.player_id == player_id } + 1
  end

  def calculate_performance_index
    self.overall_performance_index = begin
      (overall_score * overall_score * 100) / (overall_score + overall_score_against)
    rescue ZeroDivisionError
      0
    end

    self.single_performance_index = begin
      (single_score * single_score * 100) / (single_score + single_score_against)
    rescue ZeroDivisionError
      0
    end

    self.double_performance_index = begin
      (double_score * double_score * 100) / (double_score + double_score_against)
    rescue Exception => e
      0
    end
  end
end
