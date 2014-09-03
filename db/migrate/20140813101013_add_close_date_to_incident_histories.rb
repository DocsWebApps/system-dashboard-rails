class AddCloseDateToIncidentHistories < ActiveRecord::Migration
  def change
  	change_table :incident_histories do |t|
  		t.datetime :closed_at
  	end
  end
end
