class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.text :message
      t.integer :status

      t.timestamps
    end
  end
end
