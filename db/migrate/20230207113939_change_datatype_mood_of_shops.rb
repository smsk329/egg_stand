class ChangeDatatypeMoodOfShops < ActiveRecord::Migration[6.1]
  def change
    change_column :shops, :mood, :integer
  end
end
