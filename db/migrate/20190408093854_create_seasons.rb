class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :name, text: true, null: false
      t.integer :teams, array: true, null: false
      t.timestamps
    end
  end
end
