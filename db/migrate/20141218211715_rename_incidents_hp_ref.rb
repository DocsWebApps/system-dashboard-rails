class RenameIncidentsHpRef < ActiveRecord::Migration
  def change
  	rename_column :incidents, :hp_ref, :fault_ref
  end
end
