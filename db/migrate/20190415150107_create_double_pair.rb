class CreateDoublePair < ActiveRecord::Migration[6.0]
  def change
    create_table :double_pairs do |t|
      t.integer :player_ids, array: true
    end
  end
end
