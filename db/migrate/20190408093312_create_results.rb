class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.integer :match_id, null: false
      t.integer :home_player_ids, array: true, null: false
      t.integer :away_player_ids, array: true, null: false
      t.integer :home_goals, null: false
      t.integer :away_goals, null: false
      t.timestamps
    end
  end
end
