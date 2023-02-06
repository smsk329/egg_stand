class CreateGenreRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :genre_relations do |t|
      t.integer :genre_id, null: false
      t.integer :shop_id, null: false
      t.timestamps
    end
  end
end
