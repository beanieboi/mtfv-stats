class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.text :name, text: true, null: false
      t.integer :league_id
      t.integer :external_mtfv_id, null: false
      t.integer :goals
      t.integer :goals_against
      t.integer :score
      t.integer :score_against
      t.integer :matches_won
      t.integer :matches_draw
      t.integer :matches_lost
      t.integer :points
      t.timestamps
    end
  end
end
