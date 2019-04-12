class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.integer :player_id, null: false
      t.integer :league_id, null: false
      t.integer :performance_index
      t.integer :score
      t.integer :score_against
      t.integer :goals
      t.integer :goals_against
      t.timestamps
    end
  end
end
