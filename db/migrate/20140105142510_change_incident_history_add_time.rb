class ChangeIncidentHistoryAddTime < ActiveRecord::Migration
  def change
    change_table :incident_histories do |t|
      t.change :date, :date
      t.time :time
    end
  end
end
