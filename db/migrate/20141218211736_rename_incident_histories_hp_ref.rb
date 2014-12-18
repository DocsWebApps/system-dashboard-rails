class RenameIncidentHistoriesHpRef < ActiveRecord::Migration
  def change
  	rename_column :incident_histories, :hp_ref, :fault_ref
  end
end
