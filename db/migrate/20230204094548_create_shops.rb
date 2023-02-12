class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.text :body ,null: false
      t.time :open_time ,null: false
      t.time :close_time ,null: false
      t.string :address ,null: false
      t.integer :price ,null: false
      t.string :holiday ,null: false
      t.string :menu ,null: false
      t.string :mood ,null: false
      t.boolean :wifi
      t.boolean :charging
      t.boolean :cashless
      t.timestamps
    end
  end
end
