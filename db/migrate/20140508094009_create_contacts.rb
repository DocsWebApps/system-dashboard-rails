class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :contact
      t.text :message

      t.timestamps
    end
  end
end
