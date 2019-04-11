class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.datetime :played_at
      t.integer :league_id, null: false
      t.integer :external_mtfv_id, null: false
      t.integer :home_goals
      t.integer :away_goals
      t.integer :home_score
      t.integer :away_score
      t.timestamps
    end
  end
end
