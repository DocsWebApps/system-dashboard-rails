class RemoveIncidentHistoryColumns < ActiveRecord::Migration
  def change
  	remove_column :incident_histories, :title
  	remove_column :incident_histories, :resolution
  end
end
