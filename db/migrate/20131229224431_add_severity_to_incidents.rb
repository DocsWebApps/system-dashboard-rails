class AddSeverityToIncidents < ActiveRecord::Migration
  def change
    change_table :incidents do |t|
      t.string :severity
    end
    
    change_table :incident_histories do |t|
      t.string :severity
    end
    
  end
end
