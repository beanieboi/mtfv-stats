class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.integer :player_id, null: false
      t.integer :league_id, null: false
      t.integer :overall_performance_index
      t.integer :overall_score
      t.integer :overall_score_against
      t.integer :overall_goals
      t.integer :overall_goals_against
      t.integer :single_performance_index
      t.integer :single_score
      t.integer :single_score_against
      t.integer :single_goals
      t.integer :single_goals_against
      t.integer :double_performance_index
      t.integer :double_score
      t.integer :double_score_against
      t.integer :double_goals
      t.integer :double_goals_against
      t.timestamps
    end
  end
end
