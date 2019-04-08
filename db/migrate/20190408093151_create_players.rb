class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.text :name, null: false
      t.integer :team_id
      t.integer :external_mtfv_id, null: false
      t.timestamps
    end
  end
end
