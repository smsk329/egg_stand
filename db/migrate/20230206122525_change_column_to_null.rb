class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :customers, :introduction, true
  end

  def down
    change_column_null :customers, :introduction, false
  end
end
