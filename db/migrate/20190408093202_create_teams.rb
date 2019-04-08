class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.text :name, null: false
      t.integer :league_id
      t.integer :external_mtfv_id, null: false
      t.timestamps
    end
  end
end
