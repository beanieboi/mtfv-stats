class CreateDoubleStats < ActiveRecord::Migration[6.0]
  def change
    create_table :double_stats do |t|
      t.integer :player_ids, array: true, null: false
      t.integer :league_id, null: false
      t.integer :overall_performance_index, default: 0
      t.integer :overall_score, default: 0
      t.integer :overall_score_against, default: 0
      t.integer :overall_goals, default: 0
      t.integer :overall_goals_against, default: 0
      t.timestamps
    end
  end
end
