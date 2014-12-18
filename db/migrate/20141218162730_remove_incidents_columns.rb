class RemoveIncidentsColumns < ActiveRecord::Migration
  def change
  	remove_column :incidents, :title
  	remove_column :incidents, :resolution
  end
end
