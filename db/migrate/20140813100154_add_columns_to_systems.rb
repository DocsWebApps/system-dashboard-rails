class AddColumnsToSystems < ActiveRecord::Migration
  def change
  	change_table :systems do |t|
  		t.date :last_incident_date
  	end
  end
end
