class AlterSystemTable < ActiveRecord::Migration
  def change
    change_table :systems do |t|
      t.remove :message
      t.integer :dash_id
    end
  end
end
