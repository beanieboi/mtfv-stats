class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.integer :season_id
      t.text :name, text: true, null: false
      t.integer :external_mtfv_id, null: false
      t.timestamps
    end
  end
end
