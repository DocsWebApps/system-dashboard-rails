class AddCloseDateToIncidents < ActiveRecord::Migration
  def change
  	change_table :incidents do |t|
  		t.datetime :closed_at
  	end
  end
end
