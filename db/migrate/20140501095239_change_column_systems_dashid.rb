class ChangeColumnSystemsDashid < ActiveRecord::Migration
  def change
    rename_column :systems, :dash_id, :row_id
  end
end
