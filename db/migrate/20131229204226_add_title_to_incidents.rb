class AddTitleToIncidents < ActiveRecord::Migration
  def change
    change_table :incidents do |t|
      t.text :title
    end
    
    change_table :incident_histories do |t|
      t.text :title
    end
  end
end
